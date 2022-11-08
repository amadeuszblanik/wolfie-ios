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
        @AppStorage("AUTH_TOKEN") var authenticated = false {
            willSet { objectWillChange.send() }
        }
        
        @AppStorage("AUTH_USERNAME") var username: String = ""
        @Published var password: String = ""
        @Published var keepSignIn: Bool = true
        @Published var isActive: Bool = true
        @Published var isLoading: Bool = false
        @Published var isInvalid: Bool = false
        
        var errorMessage: String = "Lorem ipsum dolor sit amet"
        
        var device: String = UIDevice().name
        
        func toggleAuthenticated(_ next: Bool? = nil) {
            self.password = ""
            
            withAnimation {
                if let value = next {
                    authenticated = value
                } else {
                    authenticated.toggle()
                }
            }
        }
        
        func signIn() -> Void {
            isInvalid = false
            isActive = false
            isLoading = true
            print("Tried to sign in as \(username)/\(password) and \(keepSignIn ? "Keep session" : "Do not keep session") with device \(device)")

            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                self.isLoading = false
                self.isActive = true
                
                guard self.username.lowercased() == MOCKED_USERNAME else {
                    self.isInvalid = true
                    return
                }
                
                guard self.password == MOCKED_PASSWORD else {
                    self.isInvalid = true
                    return
                }
                
                self.toggleAuthenticated(true)
            }
        }
    }
}
