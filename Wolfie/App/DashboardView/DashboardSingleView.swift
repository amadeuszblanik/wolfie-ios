//
//  DashboardSingleView.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 10/11/2022.
//

import SwiftUI

struct DashboardSingleView: View {
    var pet: PetDB
    @Binding var path: [DashboardViews]
    
    @State private var isOpenEdit = false
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    PetCardComponent(pet: pet)
                        .padding()
                    
                    Spacer()
                    
                    HStack {
                        Button {
                            path.append(.weight(pet: pet))
                        } label: {
                            CardComponent(
                                label: String(localized: "weight"),
                                icon: "barbell-outline",
                                value: pet.currentWeight?.formatted
                            )
                        }
                        
                        Button {
                            path.append(.healthLog(pet: pet))
                        } label: {
                            CardComponent(
                                label: String(localized: "health_log"),
                                icon: "heart-outline",
                                value: String(pet.healthLog),
                                background: .red
                            )
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DashboardSingleView_Previews: PreviewProvider {
    @State static var path: [DashboardViews] = []
    
    static var previews: some View {
        DashboardSingleView(pet: PetDB.fromApi(data: PET_GOLDIE), path: $path)
        DashboardSingleView(pet: PetDB.fromApi(data: PET_GOLDIE), path: $path)
            .preferredColorScheme(.dark)
    }
}
