//
//  DashboardSingleView.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 10/11/2022.
//

import SwiftUI

struct DashboardSingleView: View {
    @Binding var pet: ApiPetSingle
    
    @State private var isOpenEdit = false
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    Button {
                        isOpenEdit = true
                    } label: {
                        PetCardComponent(pet: pet)
                    }
                    .padding()
                    .sheet(isPresented: $isOpenEdit) {
                        PetForm(vm: PetForm.ViewModel(pet: pet))
                    }
                    
                    Spacer()
                    
                    HStack {
                        Button {
                            print("Weight clicked")
                        } label: {
                            CardComponent(
                                label: String(localized: "weight"),
                                icon: "barbell-outline",
                                value: "14.2 KG"
                            )
                        }
                        
                        Button {
                            print("Health log clicked")
                        } label: {
                            CardComponent(
                                label: String(localized: "health_log"),
                                icon: "heart-outline",
                                value: "9",
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
    
    static var previews: some View {
        DashboardSingleView(pet: $pet)
        DashboardSingleView(pet: $pet)
            .preferredColorScheme(.dark)
    }
}
