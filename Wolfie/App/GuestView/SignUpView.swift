//
//  SignUpView.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 07/11/2022.
//

import SwiftUI

struct SignUpView: View {
    @State private var isGdprOpen = false
    @Binding var selectedView: GuestViews?
    @StateObject private var vm = ViewModel()
    
    var success: some View {
        Group {
            Text(vm.sucessMessage)
                .font(.largeTitle)
                .foregroundColor(Color.green)
                .multilineTextAlignment(.center)
            Spacer()
            
            UIButton(text: String(localized: "sign_in"), fullWidth: true) {
                withAnimation {
                    selectedView = .signIn
                }
            }
        }
    }
    
    var form: some View {
        Group {
            UIInput(label: String(localized: "email"), state: $vm.email, keyboardType: .emailAddress)
                .padding(.vertical)
                .textContentType(.emailAddress)
            
            UIInput(label: String(localized: "first_name"), state: $vm.firstName)
                .padding(.vertical)
                .textContentType(.givenName)
            
            UIInput(label: String(localized: "last_name"), state: $vm.lastName)
                .padding(.vertical)
                .textContentType(.familyName)
            
            UIInput(label: String(localized: "password"), state: $vm.password, type: .Password)
                .padding(.vertical)
                .textContentType(.newPassword)
            
            UIInput(label: String(localized: "password_confirm"), state: $vm.passwordConfirm, type: .Password)
                .padding(.vertical)
                .textContentType(.newPassword)

            UISelect(label: String(localized: "weight_unit"), values: WeightUnits.selectItemList, state: $vm.weightUnit)
                .padding(.vertical)
            
            UICheckbox(label: String(localized: "gdpr_consent"), state: $vm.gdprConsent)
                .padding(.vertical)
            
            Button(String(localized: "read_gdpr")) {
                isGdprOpen = true
            }
            .sheet(isPresented: $isGdprOpen) {
                WebView(url: "https://next.wolfie.app/privacy-policy")
            }
            .padding(.top)
        }
    }
    
    var body: some View {
        VStack {
            UIJumbotron(
                header: String(localized: "sign_up_header"),
                subHeader: String(localized: "sign_up_sub_header")
            )
            
            Spacer()

            VStack {
                if (vm.isSuccess) {
                    success
                } else {
                    ScrollView {
                        form
                            .padding(.bottom)
                    }
                    
                    Spacer()
                    
                    if (vm.isLoading) {
                        HStack {
                            ProgressView()
                                .padding(.trailing)
                            
                            Text(String(localized: "please_wait"))
                                .foregroundColor(Color(UIColor.secondaryLabel))
                        }
                        .padding(.bottom)
                    }
                    
                    UIButton(text: String(localized: "sign_up"), fullWidth: true) {
                        vm.signUp()
                    }
                    .disabled(!vm.isActive || !vm.isFilled)
                }
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

struct SignUpView_Previews: PreviewProvider {
    @State static var selectedView: GuestViews? = GuestViews.signUp
    
    static var previews: some View {
        SignUpView(selectedView: $selectedView)
        SignUpView(selectedView: $selectedView)
            .preferredColorScheme(.dark)
    }
}
