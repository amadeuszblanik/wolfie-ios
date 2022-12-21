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
    @State private var path: [ProfileViews] = []
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

                if let total = [Float(config.userPets), Float(config.userPetsAllowed)].max() {
                    ProgressView(value: Float(config.userPets), total: total)
                }

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

    var navigationList: some View {
        List {
            Section {
                userProfile
            }

            Section {
                Button {
                    path.append(ProfileViews.updateProfile)
                } label: {
                    ProfileItemView(label: String(localized: "update_profile"))
                }

                Button {
                    path.append(ProfileViews.changePassword)
                } label: {
                    ProfileItemView(label: String(localized: "change_password"))
                }

                Button {
                    path.append(ProfileViews.authorizedDevices)
                } label: {
                    ProfileItemView(label: String(localized: "authorized_devices"))
                }

                Button {
                    path.append(ProfileViews.privacyPolicy)
                } label: {
                    ProfileItemView(label: String(localized: "read_gdpr"))
                }
            }

            Section {
                Button {
                    WolfieApi().postTestNotification { result in
                        print(result)
                    }
                } label: {
                    ProfileItemView(label: String(localized: "test_notification"))
                }
            }

            Section {
                Button {
                    path.append(ProfileViews.deleteAccount)
                } label: {
                    ProfileItemView(label: String(localized: "delete_account"))
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

    var body: some View {
        NavigationStack(path: $path) {
            navigationList
                .navigationDestination(for: ProfileViews.self) { view in
                    switch view {
                    case .updateProfile:
                        UIWebView(url: vm.updateProfileUrl, title: String(localized: "update_profile"))
                    case .changePassword:
                        UIWebView(url: vm.changePasswordUrl, title: String(localized: "change_password"))
                    case .authorizedDevices:
                        UIWebView(url: vm.authorizedDevicesUrl, title: String(localized: "authorized_devices"))
                    case .privacyPolicy:
                        UIWebView(url: vm.gdprUrl, title: String(localized: "read_gdpr"))
                    case .deleteAccount:
                        DeleteAccountView(vm: DeleteAccountView.ViewModel(onSignOff: {
                            path = []
                            vm.signOff()
                        }))
                    default:
                        Text("Not implemented yet")
                    }
                }
        }
    }
}

//struct ProfileView_Previews: PreviewProvider {
//    static var VM_0 = ProfileView.ViewModel(config: CONFIG_0, user: USER_0)
//    static var VM_1 = ProfileView.ViewModel(config: CONFIG_1, user: USER_0)
//    static var VM_2 = ProfileView.ViewModel(config: CONFIG_0, user: USER_0)
//
//    static var previews: some View {
//        ProfileView(vm: VM_0)
//        ProfileView(vm: VM_0)
//            .preferredColorScheme(.dark)
//
//        ProfileView(vm: VM_1)
//        ProfileView(vm: VM_1)
//            .preferredColorScheme(.dark)
//
//        NavigationView {
//            ProfileView(vm: VM_2)
//        }
//        NavigationView {
//            ProfileView(vm: VM_2)
//        }
//            .preferredColorScheme(.dark)
//    }
//}
