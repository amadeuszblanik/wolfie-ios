//
//  SignUpViewModel.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 08/11/2022.
//

import SwiftUI

extension SignUpView {
    @MainActor class ViewModel: ObservableObject {
        @AppStorage("AUTH_USERNAME") var email: String = ""
        @Published var firstName: String = ""
        @Published var lastName: String = ""
        @Published var password: String = ""
        @Published var passwordConfirm: String = ""
        @Published var weightUnit: String = WeightUnits.Kilogram.rawValue
        @Published var gdprConsent: Bool = false
        @Published var isActive: Bool = true
        @Published var isLoading: Bool = false
        @Published var isInvalid: Bool = false
        var isSuccess: Bool = false
        
        var sucessMessage: String = "Lorem ipsum dolor sit amet"
        var errorMessage: String = "Lorem ipsum dolor sit amet"

        func signUp() -> Void {
            isInvalid = false
            isActive = false
            isLoading = true
            print("Tried to sign up as \(firstName)\n\(lastName)\n\(password)\n\(passwordConfirm)\n\(weightUnit)\n\(gdprConsent ? "gdprConsent – true" : "gdprConsent – false")")

            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                self.isLoading = false
                self.isActive = true

                guard self.password == MOCKED_PASSWORD else {
                    self.isInvalid = true
                    return
                }

                self.isSuccess = true
            }
        }
    }
}
