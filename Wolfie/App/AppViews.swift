//
//  AppViews.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 07/11/2022.
//

import Foundation
import SwiftUI

enum AppViews {
    case guest
    case dev
    case app
}

enum GuestViews: String, CaseIterable {
    case signIn = "sign_in"
    case signUp = "sign_up"
    
    var localized: String {
        return String(localized: LocalizedStringResource(stringLiteral: rawValue))
    }
}
