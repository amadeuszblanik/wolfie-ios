//
//  DashboardSingleView.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 10/11/2022.
//

import SwiftUI

struct DashboardSingleView: View {
    @Binding var pet: ApiPetSingle
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
                            path.append(.weight)
                        } label: {
                            CardComponent(
                                label: String(localized: "weight"),
                                icon: "barbell-outline",
                                value: pet.currentWeight?.formatted
                            )
                        }
                        
                        Button {
                            print("Health log clicked")
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
    @State static var pet = PET_GOLDIE
    @State static var path: [DashboardViews] = []
    
    static var previews: some View {
        DashboardSingleView(pet: $pet, path: $path)
        DashboardSingleView(pet: $pet, path: $path)
            .preferredColorScheme(.dark)
    }
}
