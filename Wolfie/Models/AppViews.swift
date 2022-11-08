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
        }
    }
}

enum AppDevViews: String, CaseIterable {
    case main = "MainView()"
    case guest = "GuestView()"
    case dashboard = "DashboardView()"
    case profile = "ProfileView()"
}

enum GuestViews: String, CaseIterable {
    case signIn = "sign_in"
    case signUp = "sign_up"
    
    var localized: String {
        return String(localized: LocalizedStringResource(stringLiteral: rawValue))
    }
}
