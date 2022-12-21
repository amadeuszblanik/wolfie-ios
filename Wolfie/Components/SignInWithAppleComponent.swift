//
//  SignInWithAppleComponent.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 05/12/2022.
//

import SwiftUI
import _AuthenticationServices_SwiftUI

struct UISignInWithApple: View {
    @AppStorage("AUTH_SIGNED") var isSigned: Bool?
    @Environment(\.colorScheme) var currentScheme

    func setIsSigned(_ next: Bool? = nil) {
        withAnimation {
            isSigned = next
        }
    }

    func handleRequest(request: ASAuthorizationAppleIDRequest) {
        request.requestedScopes = [.fullName, .email]
    }

    func handleCompletion(completion result: Result<ASAuthorization, Error>) {
        switch result {
        case .success(let auth):
            guard let credential = auth.credential as? ASAuthorizationAppleIDCredential,
                  let idTokenData = credential.identityToken,
                  let codeData = credential.authorizationCode,
                  let idToken = String(data: idTokenData, encoding: .utf8),
                  let code = String(data: codeData, encoding: .utf8)
            else {
                print("🍎 Failed to authenticate")

                return
            }
            print("🍎 \(auth)")

            let payload = DtoSignWithApple(
                state: credential.state,
                idToken: idToken,
                code: code,
                firstName: credential.fullName?.givenName,
                lastName: credential.fullName?.familyName,
                email: credential.email
            )

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
                    } catch {
//                        self.errorMessage = String(localized: "error_keychain_generic_message")
                    }
                case .failure(let error):
                    print("🍎  Failed! \(error)")
                }
            }
        case .failure(let error):
            print("🍎 \(error)")
        }
    }

    var body: some View {
        ZStack{
            ZStack {
                Color.primary
                    .opacity(0.88)
                    .edgesIgnoringSafeArea(.all)
                Spacer()
                ProgressView()
                    .tint(.white)
                Spacer()
            }
            .frame(width: .infinity, height: .infinity)
            .background(.secondary)
            .zIndex(1000)
            SignInWithAppleButton(
                .continue,
                onRequest: handleRequest,
                onCompletion: handleCompletion
            )
            .frame(height: 60)
            .signInWithAppleButtonStyle(self.currentScheme == .light ? .black : .white)
        }
    }
}

struct UISignInWithApple_Previews: PreviewProvider {
    static var previews: some View {
        UISignInWithApple()
        UISignInWithApple()
            .preferredColorScheme(.dark)
    }
}
