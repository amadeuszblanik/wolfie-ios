//
//  DashboardView.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 08/11/2022.
//

import SwiftUI

struct DashboardView: View {
    var body: some View {
        ScrollView {
            PetCardComponent()
                .padding(.bottom)
            PetCardComponent()
                .padding(.bottom)
            PetCardComponent()
                .padding(.bottom)
        }
        .padding()
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
        DashboardView()
            .preferredColorScheme(.dark)
    }
}
