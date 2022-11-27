//
//  MainView.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 07/11/2022.
//

import SwiftUI

struct MainView: View {
    @State private var selectedView: AppViews = AppViews.dashboard
    @StateObject private var vm = ViewModel()
    @StateObject var realmDb = RealmManager()
    
    var signed: some View {
        Group {
            NavigationView {
                VStack {
                    switch (selectedView) {
                    case .dashboard:
                        DashboardView()
                    case .profile:
                        ProfileView()
                    }
                }
                    .toolbar {
                        ToolbarItemGroup(placement: .bottomBar) {
                            ForEach(AppViews.allCases, id: \.self) { appView in
                                Button {
                                    withAnimation {
                                        selectedView = appView
                                    }
                                } label: {
                                    appView.icon
                                        .resizable()
                                        .scaleEffect()
                                        .frame(width: 24, height: 24)
                                        .padding()
                                }
                            }
                        }
                    }
            }
        }.onAppear {
            realmDb.fetchUser()
        }
    }
    
    var body: some View {
        VStack {
            if vm.isSigned ?? false {
                signed
            } else {
                GuestView()
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
