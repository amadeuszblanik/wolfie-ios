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
        @AppStorage("AUTH_ACCESS_TOKEN") var accessToken: String? {
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
        
        func setAccessToken(_ next: String? = nil) {
            self.password = ""
            
            withAnimation {
                accessToken = next
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
                    print("Response")
                    debugPrint(response)
                    
                    self.accessToken = response.accessToken
                    KeychainService.standard.save(Data(response.accessToken.utf8), service: "access-token", account: "wolfie")

                    if let refreshToken = response.refreshToken {
                        KeychainService.standard.save(Data(refreshToken.utf8), service: "refresg-token", account: "wolfie")
                    }
                case .failure(let error):
                    self.isInvalid = true
                    self.isActive = true
                    self.isLoading = false
                    
                    switch error {
                    case .server(let message):
                        self.errorMessage = message
                    default:
                        self.errorMessage = "Something went wrong"
                    }
                }
            }
        }
    }
}
