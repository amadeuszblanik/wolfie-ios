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
        @Published var isSuccess: Bool = false

        var isFilled: Bool {
            !firstName.isEmpty && !lastName.isEmpty && !password.isEmpty && !passwordConfirm.isEmpty && !weightUnit.isEmpty && gdprConsent
        }

        var sucessMessage: String = "Lorem ipsum dolor sit amet"
        var errorMessage: String = "Lorem ipsum dolor sit amet"

        func signUp() {
            hideKeyboard()
            isActive = false
            isLoading = true

            let payload: DtoSignUp = DtoSignUp(
                email: self.email,
                firstName: self.firstName,
                lastName: self.lastName,
                password: self.password,
                passwordConfirm: self.passwordConfirm,
                weightUnit: self.weightUnit,
                gdprConsent: self.gdprConsent
            )

            WolfieApi().postSignUp(body: payload) { result in
                switch result {
                case .success(let response):
                    self.isSuccess = true
                    self.sucessMessage = response.message
                case .failure(let error):
                    self.isInvalid = true
                    self.isActive = true
                    self.isLoading = false
                    self.isSuccess = false

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
