//
//  SignInWithAppleComponentViewModel.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 21/12/2022.
//

import SwiftUI
import AuthenticationServices

extension UISignInWithApple {
    class ViewModel: ObservableObject {
        @AppStorage("AUTH_SIGNED") var isSigned: Bool?

        @Published var isLoading = false
        @Published var isError = false
        @Published var isSheet = false
        var errorMessage = String(localized: "error_keychain_generic_message")
        var device: String = UIDevice().name

        func setIsSigned(_ next: Bool? = nil) {
            withAnimation {
                isSigned = next
            }
        }

        func handleRequest(request: ASAuthorizationAppleIDRequest) {
            request.requestedScopes = [.fullName, .email]
        }

        func handleCompletion(completion result: Result<ASAuthorization, Error>) {
            isSheet = true
            isLoading = true
            isError = false

            switch result {
            case .success(let auth):
                guard let credential = auth.credential as? ASAuthorizationAppleIDCredential,
                    let idTokenData = credential.identityToken,
                    let codeData = credential.authorizationCode,
                    let idToken = String(data: idTokenData, encoding: .utf8),
                    let code = String(data: codeData, encoding: .utf8)
                    else {
                    sentryLog("Cannot sign in with apple — guard checking")
                    self.errorMessage = String(localized: "error_sign_in_with_apple_device_message")
                    self.isError = true
                    self.isLoading = false

                    return
                }

                let payload = DtoSignWithApple(
                    state: credential.state,
                    idToken: idToken,
                    code: code,
                    firstName: credential.fullName?.givenName,
                    lastName: credential.fullName?.familyName,
                    email: credential.email,
                    device: device
                )

                self.signIn(payload: payload)
            case .failure(let error):
                guard (error as NSError).code == 1001 else {
                    print(error)
                    sentryLog("Cannot sign in with apple — \(error.localizedDescription)")
                    self.errorMessage = String(localized: "error_sign_in_with_apple_device_message")
                    self.isError = true
                    self.isLoading = false

                    return
                }

                self.isSheet = false
                self.isError = false
                self.isLoading = false
            }
        }

        private func signIn(payload: DtoSignWithApple) {
            WolfieApi().postSignInWithApple(body: payload) { result in
                switch result {
                case .success(let response):
                    do {
                        try KeychainService.standard.save(
                            Data(response.accessToken.utf8),
                            service: "access-token",
                            account: "wolfie"
                        )

                        if let refreshToken = response.refreshToken {
                            try KeychainService.standard.save(
                                Data(refreshToken.utf8),
                                service: "refresh-token",
                                account: "wolfie"
                            )
                        }

                        self.setIsSigned(true)
                        FirebaseService().updateFcmToken()
                        self.isLoading = false
                    } catch {
                        sentryLog("Cannot sign in with apple > KEYCHAIN — \(error.localizedDescription)")
                        self.errorMessage = String(localized: "error_sign_in_with_apple_device_message")
                        self.isError = true
                        self.isLoading = false
                    }
                case .failure(let error):
                    switch error {
                    case .server(let message):
                        self.errorMessage = message
                    default:
                        sentryLog("Cannot sign in with apple > POST — \(error.localizedDescription)")
                        self.errorMessage = String(localized: "error_sign_in_with_apple_server_message")
                    }

                    self.isError = true
                    self.isLoading = false
                }
            }
        }
    }
}
