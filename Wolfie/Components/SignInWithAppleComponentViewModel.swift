//
//  SignInWithAppleComponentViewModel.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 21/12/2022.
//

import SwiftUI
import AuthenticationServices

extension UISignInWithApple {
//    @MainActor class ViewModel: ObservableObject {
//        @AppStorage("AUTH_SIGNED") var isSigned: Bool?
//
//        @Published var isLoading = false
//    }
//    
//    func setIsSigned(_ next: Bool? = nil) {
//        withAnimation {
//            isSigned = next
//        }
//    }
//
//    func handleRequest(request: ASAuthorizationAppleIDRequest) {
//        request.requestedScopes = [.fullName, .email]
//    }
//
//    func handleCompletion(completion result: Result<ASAuthorization, Error>) {
//        switch result {
//        case .success(let auth):
//            guard let credential = auth.credential as? ASAuthorizationAppleIDCredential,
//                  let idTokenData = credential.identityToken,
//                  let codeData = credential.authorizationCode,
//                  let idToken = String(data: idTokenData, encoding: .utf8),
//                  let code = String(data: codeData, encoding: .utf8)
//            else {
//                print("🍎 Failed to authenticate")
//
//                return
//            }
//            print("🍎 \(auth)")
//
//            let payload = DtoSignWithApple(
//                state: credential.state,
//                idToken: idToken,
//                code: code,
//                firstName: credential.fullName?.givenName,
//                lastName: credential.fullName?.familyName,
//                email: credential.email
//            )
//
//            WolfieApi().postSignInWithApple(body: payload) { result in
//                switch result {
//                case .success(let response):
//                    do {
//                        try KeychainService.standard.save(
//                            Data(response.accessToken.utf8),
//                            service: "access-token",
//                            account: "wolfie"
//                        )
//
//                        if let refreshToken = response.refreshToken {
//                            try KeychainService.standard.save(
//                                Data(refreshToken.utf8),
//                                service: "refresh-token",
//                                account: "wolfie"
//                            )
//                        }
//
//                        self.setIsSigned(true)
//                        FirebaseService().updateFcmToken()
//                    } catch {
////                        self.errorMessage = String(localized: "error_keychain_generic_message")
//                    }
//                case .failure(let error):
//                    print("🍎  Failed! \(error)")
//                }
//            }
//        case .failure(let error):
//            print("🍎 \(error)")
//        }
//    }
}
