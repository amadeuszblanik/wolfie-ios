//
//  WolfieApp.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 03/11/2022.
//

import SwiftUI

let colors: [Color] = [.purple, .pink, .orange]

@main
struct WolfieApp: App {
    let persistenceController = PersistenceController.shared
    
    let colors: [Color] = [.purple, .pink, .orange]
    @State private var selection: Color? = nil

    var body: some Scene {
        WindowGroup {
            VStack() {                
                #if DEBUG
                MainDevView()
                #else
                MainView()
                #endif
            }
        }
    }
}
