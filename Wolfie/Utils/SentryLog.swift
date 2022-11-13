//
//  SentryLog.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 12/11/2022.
//

import Foundation
import Sentry

func sentryLog(_ domain: String, code: Int = 0, userInfo: [String: Any]? = nil) -> Void {
    let error = NSError(domain: domain, code: code, userInfo: userInfo)
    
    #if DEBUG
    print("⚠️ Warning \(domain)")
    debugPrint(error)
    #endif

    SentrySDK.capture(error: error)
}
