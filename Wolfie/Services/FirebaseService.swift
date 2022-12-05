//
//  FirebaseService.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 05/12/2022.
//

import Foundation

final class FirebaseService {
    func updateFcmToken() {
        if !UserDefaults.standard.bool(forKey: "AUTH_SIGNED") {
            print("🔥 Cannot update FCM Token due to not signed in user")
            return
        }

        guard let fcmToken = UserDefaults.standard.string(forKey: "FCM_TOKEN") else {
            print("🔥 Cannot update FCM Token due to missing FCM token")
            sentryLog("Cannot update FCM Token due to missing FCM token")
            return
        }

        guard let deviceTokenData = KeychainService.standard.read(service: "refresh-token", account: "wolfie") else {
            print("🔥 Cannot update FCM Token due to missing refresh token")
            sentryLog("Cannot update FCM Token due to missing refresh token")
            return
        }

        guard let deviceToken = String(data: deviceTokenData, encoding: .utf8) else {
            print("🔥 Cannot update FCM Token due to decoding refresh token")
            sentryLog("Cannot update FCM Token due to decoding refresh token")
            return
        }

        let payload = DtoFcmToken(deviceToken: deviceToken, fcmToken: fcmToken)

        WolfieApi().postFcmToken(body: payload) { result in
            switch result {
            case .success:
                print("🔥 Successfully updated FCM Token with \(fcmToken)")
            case .failure(let error):
                print("🔥 Cannot updated FCM Token due to \(error.localizedDescription)")
                sentryLog("Cannot updated FCM Token due to \(error.localizedDescription)")
            }
        }
    }
}
