//
//  SignInWithAppleComponent.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 05/12/2022.
//

import SwiftUI
import _AuthenticationServices_SwiftUI

struct UISignInWithApple: View {
    @Environment(\.colorScheme) var currentScheme
    @ObservedObject var vm = ViewModel()

    var body: some View {
        ZStack {
            SignInWithAppleButton(
                .continue,
                onRequest: vm.handleRequest,
                onCompletion: vm.handleCompletion
            )
            .frame(height: 60)
            .signInWithAppleButtonStyle(self.currentScheme == .light ? .black : .white)
            .sheet(isPresented: $vm.isSheet) {
                VStack {
                    if vm.isError {
                        UIStatus(vm.errorMessage)
                    } else {
                        ProgressView()
                            .padding(.bottom)
                        Text(String(localized: "please_wait"))
                    }
                }
                .interactiveDismissDisabled(vm.isLoading)
            }
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
