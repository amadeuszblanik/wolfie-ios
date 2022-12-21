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

    var systemImage: String {
        switch self {
        case .dashboard:
            return "circle.grid.3x3"

        case .profile:
            return "person"
        }
    }

    var view: AnyView {
        switch self {
        case .dashboard:
            return AnyView(DashboardView())

        case .profile:
            return AnyView(ProfileView())
        }
    }

    var label: String {
        switch self {
        case .dashboard:
            return String(localized: "dashboard")

        case .profile:
            return String(localized: "profile")
        }
    }

    var icon: Image {
        switch self {
        case .dashboard:
            return Image("apps-outline")

        case .profile:
            return Image("person-outline")
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
