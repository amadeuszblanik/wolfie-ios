//
//  MainDevView.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 07/11/2022.
//

import SwiftUI
import RealmSwift

struct MainDevView: View {
    @State private var selectedView: AppDevViews?
    @StateObject var realmDb = RealmManager()
    @AppStorage("AUTH_ACCESS_TOKEN") var accessToken: String?

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
                    Button("Clear access-token") {
                        accessToken = ""
                        KeychainService.standard.delete(service: "access-token", account: "wolfie")
                    }
                    Button("Clear refresh-token") {
                        KeychainService.standard.delete(service: "refresh-token", account: "wolfie")
                    }
                }

                Section("Config") {
                    HStack(alignment: .firstTextBaseline) {
                        Text("API URL")

                        Spacer()

                        Text(Bundle.main.infoDictionary?["ApiUrl"] as? String ?? "https://api.wolfie.app/v1")
                    }

                    HStack(alignment: .firstTextBaseline) {
                        Text("Web URL")

                        Spacer()

                        Text(Bundle.main.infoDictionary?["WebUrl"] as? String ?? "https://wolfie.app")
                    }

                    HStack(alignment: .firstTextBaseline) {
                        Text("Sentry DSN")

                        Spacer()

                        Text(Bundle.main.infoDictionary?["SentryDsn"] as? String ?? "——")
                            .multilineTextAlignment(.trailing)
                            .frame(alignment: .trailing)
                    }

                    HStack(alignment: .firstTextBaseline) {
                        Text("Sentry Environment")

                        Spacer()

                        Text(Bundle.main.infoDictionary?["SentryEnvironment"] as? String ?? "——")
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
                case .error:
                    ErrorView()
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
