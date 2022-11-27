//
//  SignInViewModel.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 08/11/2022.
//

import SwiftUI

let MOCKED_USERNAME = "amadeusz@blanik.me"
let MOCKED_PASSWORD = "Passw0rd!1"

extension SignInView {
    @MainActor class ViewModel: ObservableObject {
        @AppStorage("AUTH_SIGNED") var isSigned: Bool? {
            willSet { objectWillChange.send() }
        }
        
        @AppStorage("AUTH_USERNAME") var username: String = ""
        @Published var password: String = ""
        @Published var keepSignIn: Bool = true
        @Published var isActive: Bool = true
        @Published var isLoading: Bool = false
        @Published var isInvalid: Bool = false
        
        
        var isFilled: Bool {
            !username.isEmpty && !password.isEmpty
        }

        var errorMessage: String = ""
        
        var device: String = UIDevice().name
        
        func setIsSigned(_ next: Bool? = nil) {
            self.password = ""
            
            withAnimation {
                isSigned = next
            }
        }
        
        func signIn() -> Void {
            isActive = false
            isLoading = true
            
            let payload: DtoSignIn = DtoSignIn(
                username: self.username,
                password: self.password,
                keepSignIn: self.keepSignIn,
                device: UIDevice().name
            )
            
            WolfieApi().postSignIn(body: payload) { result in
                switch result {
                case .success(let response):
                    do {
                        try KeychainService.standard.save(Data(response.accessToken.utf8), service: "access-token", account: "wolfie")
                        
                        if let refreshToken = response.refreshToken {
                            try KeychainService.standard.save(Data(refreshToken.utf8), service: "refresh-token", account: "wolfie")
                        }
                        
                        self.setIsSigned(true)
                    } catch {
                        self.isInvalid = true
                        self.isActive = true
                        self.isLoading = false
                        self.errorMessage = String(localized: "error_keychain_generic_message")
                    }
                case .failure(let error):
                    self.isInvalid = true
                    self.isActive = true
                    self.isLoading = false
                    
                    switch error {
                    case .server(let message):
                        self.errorMessage = message
                    default:
                        self.errorMessage = String(localized: "error_generic_message")
                    }
                }
            }
        }
    }
}
