//
//  AppViews.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 07/11/2022.
//

import Foundation
import SwiftUI

enum AppViews: String, CaseIterable {
    case dashboard = "DashboardView()"
    case profile = "ProfileView()"

    var icon: Image {
        switch self {
        case .dashboard:
            return Image("apps-outline")

        case .profile:
            return Image("person-outline")

        default:
            return Image("help-circle-outline")
        }
    }
}

enum AppDevViews: String, CaseIterable {
    case main = "MainView()"
    case guest = "GuestView()"
    case dashboard = "DashboardView()"
    case profile = "ProfileView()"
    case playground = "PlaygroundView()"
    case error = "ErrorView()"
    case deleteAccount = "DeleteAccountView()"
}

enum GuestViews: String, CaseIterable {
    case signIn = "sign_in"
    case signUp = "sign_up"

    var localized: String {
        return String(localized: LocalizedStringResource(stringLiteral: rawValue))
    }
}

enum DashboardViews: Hashable {
    case details(pet: PetDB)
    case weight(pet: PetDB)
    case healthLog(pet: PetDB)
    case healthLogSingle(pet: PetDB, healthLog: HealthLogDB)
}

enum ProfileViews: Hashable {
    case updateProfile
    case changePassword
    case authorizedDevices
    case privacyPolicy
    case deleteAccount
}
