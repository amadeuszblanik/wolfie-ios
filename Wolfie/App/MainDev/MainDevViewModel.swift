//
//  MainDevViewModel.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 23/11/2022.
//

import SwiftUI

extension MainDevView {
    @MainActor class ViewModel: ObservableObject {
        @AppStorage("AUTH_SIGNED") var isSigned: Bool? {
            willSet { objectWillChange.send() }
        }

        @AppStorage("AUTH_USERNAME") var username: String = ""

        func signIn() {
            let payload = DtoSignIn(username: "amadeusz@blanik.me", password: "Passw0rd!1", keepSignIn: true)

            WolfieApi().postSignIn(body: payload) { result in
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
                    } catch {
                        print("failed")
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }

        private func setIsSigned(_ next: Bool? = nil) {
            withAnimation {
                isSigned = next
            }
        }
    }
}
