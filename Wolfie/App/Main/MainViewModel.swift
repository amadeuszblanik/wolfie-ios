//
//  MainViewModel.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 08/11/2022.
//

import SwiftUI

extension MainView {
    @MainActor class ViewModel: ObservableObject {
        @AppStorage("AUTH_ACCESS_TOKEN") var accessToken: String? {
            willSet { objectWillChange.send() }
        }
    }
}
