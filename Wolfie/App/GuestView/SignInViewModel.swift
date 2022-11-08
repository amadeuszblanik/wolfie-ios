//
//  SignInViewModel.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 08/11/2022.
//

import SwiftUI

extension SignInView {
    @MainActor class ViewModel: ObservableObject {
        @Published var username: String = ""
        @Published var password: String = ""
        @Published var keepSignIn: Bool = true
        @Published var isActive: Bool = true
        @Published var isLoading: Bool = false
        var device: String = UIDevice().name
        
        func signIn() -> Void {
            isActive = false
            isLoading = true
            print("Tried to sign in as \(username)/\(password) and \(keepSignIn ? "Keep session" : "Do not keep session") with device \(device)")

            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                self.isLoading = false
                self.isActive = true
            }
        }
    }
}
