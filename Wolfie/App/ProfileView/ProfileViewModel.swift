//
//  ProfileViewModel.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 12/11/2022.
//

import SwiftUI

extension ProfileView {
    @MainActor class ViewModel: ObservableObject {
        @Published var config: ApiConfig
        @Published var user: ApiUser
        @AppStorage("AUTH_ACCESS_TOKEN") var accessToken: String? {
            willSet { objectWillChange.send() }
        }
        
        private let webUrl: String = Bundle.main.infoDictionary?["WebUrl"] as? String ?? "https://wolfie.app"
        
        var updateProfileUrl: String {
            return "\(webUrl)/settings/profile"
        }
        
        var changePasswordUrl: String {
            return "\(webUrl)/settings/change-password"
        }
        
        var authorizedDevicesUrl: String {
            return "\(webUrl)/settings/authorized-devices"
        }
        
        var gdprUrl: String {
            return "\(webUrl)/privacy-policy"
        }
        
        init(config: ApiConfig = CONFIG_0, user: ApiUser = USER_0) {
            self.config = config
            self.user = user
        }
        
        func signOff() -> Void {
            KeychainService.standard.delete(service: "access-token", account: "wolfie")
            KeychainService.standard.delete(service: "refresh-token", account: "wolfie")
            
            withAnimation {
                accessToken = nil
            }
        }
    }
}
