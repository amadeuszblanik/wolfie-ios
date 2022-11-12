//
//  MainDevView.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 07/11/2022.
//

import SwiftUI
import RealmSwift

struct MainDevView: View {
    @State private var selectedView: AppDevViews? = nil
    @StateObject var realmDb = RealmManager()
    
    var body: some View {
        NavigationSplitView {
            VStack {
                Text("Development mode")
                    .font(.largeTitle)
                    .padding(.bottom)
                
                Text("Shake to back to this screen")
                    .font(.callout)
            }
            .padding(.vertical)
            
            List(selection: $selectedView) {
                Section("Views") {
                    ForEach(AppDevViews.allCases, id: \.self) { appDevView in
                        NavigationLink(appDevView.rawValue, value: appDevView)
                    }
                }
                
                Section("Utils") {
                    Button("Sentry test") {
                        sentryLog("Sentry test")
                    }
                    Button("Clear database") {
                        realmDb.clearAll()
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
        } detail: {
            if let appDevView = selectedView {
                switch appDevView {
                case .main:
                    MainView()
                case .guest:
                    GuestView()
                case .dashboard:
                    DashboardView()
                case .profile:
                    ProfileView()
                case .playground:
                    RealmPlayground()
                default:
                    Text("Not implemented yet.")
                }
            } else {
                ProgressView()
            }
        }
        .onReceive(messagePublisher) { _ in
            selectedView = nil
        }
    }
}

struct MainDevView_Previews: PreviewProvider {
    static var previews: some View {
        MainDevView()
    }
}
