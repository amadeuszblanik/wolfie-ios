//
//  SignInView.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 07/11/2022.
//

import SwiftUI

struct SignInView: View {
    @StateObject private var vm = ViewModel()

    @State static var state = ""

    var body: some View {
        VStack {
            UIJumbotron(
                header: String(localized: "sign_in_header"),
                subHeader: String(localized: "sign_in_sub_header")
            )

            Spacer()

            VStack {
                UIInput(label: String(localized: "username"), state: $vm.username, keyboardType: .emailAddress)
                    .padding(.vertical)
                    .textContentType(.username)

                UIInput(label: String(localized: "password"), state: $vm.password, type: .Password)
                    .padding(.vertical)
                    .textContentType(.password)

                Spacer()

                if vm.isLoading {
                    HStack {
                        ProgressView()
                            .padding(.trailing)

                        Text(String(localized: "please_wait"))
                            .foregroundColor(Color(UIColor.secondaryLabel))
                    }
                        .padding(.bottom)
                }

                UIButton(text: String(localized: "sign_in"), fullWidth: true) {
                    vm.signIn()
                }
                    .disabled(!vm.isActive || !vm.isFilled)
            }
                .padding()
                .alert(isPresented: $vm.isInvalid) {
                Alert(
                    title: Text(String(localized: "error_generic_title")),
                    message: Text(vm.errorMessage)
                )
            }
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()

        SignInView()
            .preferredColorScheme(.dark)
    }
}
