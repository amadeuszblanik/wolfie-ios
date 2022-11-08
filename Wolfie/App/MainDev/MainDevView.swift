//
//  MainDevView.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 07/11/2022.
//

import SwiftUI

struct MainDevView: View {
    @State private var selectedView: AppViews? = nil

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
            
            List(AppViews.allCases, id: \.self, selection: $selectedView) { appView in
                NavigationLink(appView.rawValue, value: appView)
            }
        } detail: {
            if let appView = selectedView {
                switch appView {
                case .guest:
                    GuestView()
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
