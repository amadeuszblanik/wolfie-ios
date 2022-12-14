//
//  WolfieApp.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 03/11/2022.
//

import SwiftUI
import Sentry

@main
struct WolfieApp: SwiftUI.App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    let persistenceController = PersistenceController.shared

    init() {
        guard let infoDictionary: [String: Any] = Bundle.main.infoDictionary else {
            print("Cannot read infoDictionary")
            return
        }
        guard let sentryDsn: String = infoDictionary["SentryDsn"] as? String else {
            print("Cannot read SentryDsn")
            return
        }
        let sentryEnvironment: String = infoDictionary["SentryEnvironment"] as? String ?? "unknown"

        SentrySDK.start { options in
            options.dsn = sentryDsn
            options.environment = sentryEnvironment
            options.debug = false

            // Set tracesSampleRate to 1.0 to capture 100% of transactions for performance monitoring.
            // We recommend adjusting this value in production.
            options.tracesSampleRate = 1.0

            // Features turned off by default, but worth checking out
            options.enableAppHangTracking = true
            options.enableFileIOTracking = true
            options.enableCoreDataTracking = true
            options.enableCaptureFailedRequests = true
            options.attachScreenshot = sentryEnvironment != "production"
        }
    }

    var body: some Scene {
        WindowGroup {
            VStack() {
//                #if DEBUG
//                    MainDevView()
//                #else
                    MainView()
//                #endif
            }
        }
    }
}
