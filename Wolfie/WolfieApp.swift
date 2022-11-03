//
//  WolfieApp.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 03/11/2022.
//

import SwiftUI

@main
struct WolfieApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
