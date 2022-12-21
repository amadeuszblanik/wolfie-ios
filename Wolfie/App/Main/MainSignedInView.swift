//
//  MainSignedInView.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 21/12/2022.
//

import SwiftUI

struct MainSignedInView: View {
    var body: some View {
        TabView {
            ForEach(AppViews.allCases, id: \.self) { appView in
                appView.view
                    .tabItem {
                        Label(appView.label, systemImage: appView.systemImage)
                    }
            }
        }
    }
}

struct MainSignedInView_Previews: PreviewProvider {
    static var previews: some View {
        MainSignedInView()
    }
}
