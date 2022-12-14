//
//  MainView.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 07/11/2022.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var networkMonitor = NetworkService()
    @State private var selectedView: AppViews = AppViews.dashboard
    @StateObject private var vm = ViewModel()
    @StateObject var realmDb = RealmManager()

    var body: some View {
        VStack {
            if networkMonitor.isConnected {
                if vm.isOffline ?? false {
                    ErrorView(
                        title: String(localized: "error_api_title"),
                        message: String(localized: "error_api_message"),
                        feedback: true
                    ) {
                        realmDb.fetchUser()
                    }
                } else {
                    if vm.isSigned ?? false {
                        MainSignedInView()
                    } else {
                        GuestView()
                    }
                }
            } else {
                ErrorView(
                    title: String(localized: "error_offline_title"),
                    message: String(localized: "error_offline_message")
                )
            }
        }
            .navigationBarHidden(true)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
        MainView()
            .preferredColorScheme(.dark)
    }
}
