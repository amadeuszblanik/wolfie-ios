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
    
    var signed: some View {
        Group {
            NavigationView {
                VStack {
                    switch (selectedView) {
                    case .dashboard:
                        DashboardView()
                    case .profile:
                        VStack {
                            Text("Signed in")
                            Button("Sign off") {
                                vm.signOff()
                            }
                            .buttonStyle(.bordered)
                        }
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
        }
    }
    
    var body: some View {
        if !vm.authenticated {
            GuestView()
        } else {
            signed
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
        MainView()
            .preferredColorScheme(.dark)
    }
}
