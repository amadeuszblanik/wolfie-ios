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
        @AppStorage("AUTH_TOKEN") var authenticated = true {
            willSet { objectWillChange.send() }
        }
        
        init(config: ApiConfig = CONFIG_0, user: ApiUser = USER_0) {
            self.config = config
            self.user = user
            self.authenticated = authenticated
        }
        
        func signOff() -> Void {
            withAnimation {
                authenticated = false
            }
        }
    }
}
