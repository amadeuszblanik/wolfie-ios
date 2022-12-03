//
//  DeleteUserViewModel.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 03/12/2022.
//

import SwiftUI

extension DeleteAccountView {
    @MainActor class ViewModel: ObservableObject {
        var onSignOff: () -> Void
        @Published var password = ""
        @Published var isAlert = false
        var isInvalid = false
        var isLoading = false
        var alertMessage = String(localized: "error_generic_message")

        init(onSignOff: @escaping () -> Void) {
            self.onSignOff = onSignOff
        }

        func deactivateAccount() {
            self.isLoading = true
            self.isInvalid = false
            let payload = DtoDeleteUser(password: self.password)

            WolfieApi().deleteDeactivateUser(body: payload) { result in
                switch result {
                case .success(let response):
                    self.isAlert = true
                    self.alertMessage = response.message
                case .failure(let error):
                    self.isAlert = true
                    self.isInvalid = true
                    self.isLoading = false

                    switch error {
                    case .server(let message):
                        self.alertMessage = message
                    default:
                        self.alertMessage = String(localized: "error_generic_message")
                    }
                }
            }
        }

        func deleteAccount() {
            self.isLoading = true
            self.isInvalid = false
            let payload = DtoDeleteUser(password: self.password)

            WolfieApi().deleteUser(body: payload) { result in
                switch result {
                case .success(let response):
                    self.isAlert = true
                    self.alertMessage = response.message
                case .failure(let error):
                    self.isAlert = true
                    self.isInvalid = true
                    self.isLoading = false

                    switch error {
                    case .server(let message):
                        self.alertMessage = message
                    default:
                        self.alertMessage = String(localized: "error_generic_message")
                    }
                }
            }
        }
    }
}
