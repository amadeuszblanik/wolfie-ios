//
//  MainViewModel.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 08/11/2022.
//

import SwiftUI

extension MainView {
    @MainActor class ViewModel: ObservableObject {
        @AppStorage("AUTH_SIGNED") var isSigned: Bool? {
            willSet { objectWillChange.send() }
        }
        @AppStorage("IS_OFFLINE") var isOffline: Bool? {
            willSet { objectWillChange.send() }
        }
    }
}
