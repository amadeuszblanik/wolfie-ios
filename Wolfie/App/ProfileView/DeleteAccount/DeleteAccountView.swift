//
//  DeactivateUserView.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 03/12/2022.
//

import SwiftUI

struct DeleteAccountView: View {
    @ObservedObject var vm: ViewModel

    @State var deletionConfirmation = false
    @State var deactivationConfirmation = false

    var form: some View {
        Group {
            UIInput(
                label: String(localized: "password"),
                state: $vm.password,
                type: .Password
            )
        }
    }

    var body: some View {
        VStack {
            UIJumbotron(
                header: String(localized: "delete_account_header"),
                subHeader: String(localized: "delete_account_sub_header")
            )

            List {
                Section {
                    Text("delete_account_introduction_content_0")
                    Text("delete_account_introduction_content_1")
                } header: {
                    Text("delete_account_introduction_header")
                }
                .listRowBackground(Color(UIColor.secondarySystemBackground))

                Section {
                    Text("delete_account_immediately_content_0")
                    UICheckbox(
                        label: String(localized: "delete_account_immediately_confirmation_content"),
                        state: $deletionConfirmation
                    )
                    if deletionConfirmation {
                        form
                    }
                    UIButton(text: String(localized: "delete_account"), color: .red, fullWidth: true) {
                        vm.deleteAccount()
                    }
                    .disabled(!deletionConfirmation && !vm.isLoading)
                } header: {
                    Text("delete_account_immediately_header")
                }
                .listRowBackground(Color(UIColor.secondarySystemBackground))

                Section {
                    Text("delete_account_deactivate_content_0")
                    UICheckbox(
                        label: String(localized: "delete_account_deactivate_confirmation_content"),
                        state: $deactivationConfirmation
                    )
                    if deactivationConfirmation {
                        form
                    }
                    UIButton(text: String(localized: "deactivate_account"), color: .red, fullWidth: true) {
                        vm.deactivateAccount()
                    }
                    .disabled(!deactivationConfirmation && !vm.isLoading)
                } header: {
                    Text("delete_account_deactivate_header")
                }
                .listRowBackground(Color(UIColor.secondarySystemBackground))

                Section {
                    Text("delete_account_backup_content_0")
                } header: {
                    Text("delete_account_backup_header")
                }
                .listRowBackground(Color(UIColor.secondarySystemBackground))
            }
            .listStyle(.insetGrouped)
            .scrollContentBackground(.hidden)
            .overlay {
                if vm.isLoading {
                    Color(white: 0, opacity: 0.75)
                    ProgressView()
                        .tint(.white)
                }
            }
            .alert(isPresented: $vm.isAlert) {
                Alert(
                    title: Text(String(localized: vm.isInvalid ? "error_generic_title" : "success_generic_message")),
                    message: Text(vm.alertMessage),
                    dismissButton: vm.isInvalid ? .cancel() : .destructive(Text(String(localized: "sign_off"))) {
                        vm.onSignOff()
                    }
                )
            }

            Spacer()
        }
    }
}

struct DeleteAccountView_Previews: PreviewProvider {
    static var VM = DeleteAccountView.ViewModel {
        print("SignOff")
    }

    static var previews: some View {
        DeleteAccountView(vm: VM)
        DeleteAccountView(vm: VM)
            .preferredColorScheme(.dark)
    }
}
