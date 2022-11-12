//
//  ProfileView.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 12/11/2022.
//

import SwiftUI

struct ProfileItemView: View {
    var label: String
    
    var body: some View {
        HStack {
            Text(label)
            
            Spacer()
            
            Image(systemName: "chevron.right")
        }
        .foregroundColor(Color(UIColor.label))
    }
}

struct ProfileView: View {
    @State private var isUpdateProfilOpen = false
    @State private var isChangePasswordOpen = false
    @State private var isAuthorizedDevicesOpen = false
    @State private var isGdprOpen = false
    @StateObject var vm = ViewModel()
    
    var userProfile: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .lastTextBaseline) {
                Text(vm.user.fullName)
                    .font(.title2)

                Text(vm.config.role.localized)
                    .foregroundColor(Color(UIColor.secondaryLabel))
            }

            HStack {
                Text(String(localized: "user_pets") + ": ")
                Text(vm.config.userPets.formatted())
                Text("/")
                Text(vm.config.userPetsAllowed.formatted())
            }

            ProgressView(value: Float(vm.config.userPets), total: Float(vm.config.userPetsAllowed))
            
            if (!vm.config.canAddNewPet) {
                Text(String(localized: "user_out_of_limit"))
                    .font(.caption)
            }
        }
        .padding(.vertical)
        .cornerRadius(8)
    }
    
    var body: some View {
        VStack {
            List {
                Section {
                    userProfile
                }

                Section {
                    Button {
                        isUpdateProfilOpen = true
                    } label: {
                        ProfileItemView(label: String(localized: "update_profile"))
                    }
                    .sheet(isPresented: $isUpdateProfilOpen) {
                        WebView(url: "https://next.wolfie.app/settings/profile")
                    }
                    
                    Button {
                        isChangePasswordOpen = true
                    } label: {
                        ProfileItemView(label: String(localized: "change_password"))
                    }
                    .sheet(isPresented: $isChangePasswordOpen) {
                        WebView(url: "https://next.wolfie.app/settings/change-password")
                    }
                    
                    Button {
                        isAuthorizedDevicesOpen = true
                    } label: {
                        ProfileItemView(label: String(localized: "authorized_devices"))
                    }
                    .sheet(isPresented: $isAuthorizedDevicesOpen) {
                        WebView(url: "https://next.wolfie.app/settings/authorized-devices")
                    }
                    
                    Button {
                        isGdprOpen = true
                    } label: {
                        ProfileItemView(label: String(localized: "read_gdpr"))
                    }
                    .sheet(isPresented: $isGdprOpen) {
                        WebView(url: "https://next.wolfie.app/privacy-policy")
                    }
                    
                    Button {
                        vm.signOff()
                    } label: {
                        ProfileItemView(label: String(localized: "sign_off"))
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(vm: ProfileView.ViewModel(config: CONFIG_0, user: USER_0))
        ProfileView(vm: ProfileView.ViewModel(config: CONFIG_0, user: USER_0))
            .preferredColorScheme(.dark)
        
        ProfileView(vm: ProfileView.ViewModel(config: CONFIG_1, user: USER_0))
        ProfileView(vm: ProfileView.ViewModel(config: CONFIG_1, user: USER_0))
            .preferredColorScheme(.dark)
        
        NavigationView {
            ProfileView(vm: ProfileView.ViewModel(config: CONFIG_0, user: USER_0))
        }
        NavigationView {
            ProfileView(vm: ProfileView.ViewModel(config: CONFIG_0, user: USER_0))
        }
            .preferredColorScheme(.dark)
    }
}
