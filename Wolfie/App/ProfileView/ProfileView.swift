//
//  ProfileView.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 12/11/2022.
//

import SwiftUI
import RealmSwift

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
    @StateObject var realmDb = RealmManager()
    @ObservedResults(ConfigDB.self) var configDb
    @ObservedResults(UserDB.self) var userDb

    var userProfile: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .lastTextBaseline) {
                Text(userDb.first?.fullName ?? "—")
                    .font(.title2)

                Text(configDb.first?.role.localized ?? "—")
                    .foregroundColor(Color(UIColor.secondaryLabel))
            }

            if let config = configDb.first {
                HStack {
                    Text(String(localized: "user_pets") + ": ")
                    Text(config.userPets.formatted())
                    Text("/")
                    Text(config.userPetsAllowed.formatted())
                }

                ProgressView(value: Float(config.userPets), total: Float(config.userPetsAllowed))

                if !config.canAddNewPet {
                    Text(String(localized: "user_out_of_limit"))
                        .font(.caption)
                }
            }
        }
            .padding(.vertical)
            .cornerRadius(8)
            .onAppear {
                realmDb.fetchUser()
        }
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
                        UIWebView(url: vm.updateProfileUrl, title: String(localized: "update_profile"))
                    }

                    Button {
                        isChangePasswordOpen = true
                    } label: {
                        ProfileItemView(label: String(localized: "change_password"))
                    }
                        .sheet(isPresented: $isChangePasswordOpen) {
                        UIWebView(url: vm.changePasswordUrl, title: String(localized: "change_password"))
                    }

                    Button {
                        isAuthorizedDevicesOpen = true
                    } label: {
                        ProfileItemView(label: String(localized: "authorized_devices"))
                    }
                        .sheet(isPresented: $isAuthorizedDevicesOpen) {
                        UIWebView(url: vm.authorizedDevicesUrl, title: String(localized: "authorized_devices"))
                    }

                    Button {
                        isGdprOpen = true
                    } label: {
                        ProfileItemView(label: String(localized: "read_gdpr"))
                    }
                        .sheet(isPresented: $isGdprOpen) {
                        UIWebView(url: vm.gdprUrl, title: String(localized: "read_gdpr"))
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
