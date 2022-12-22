//
//  DashboardSingleView.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 10/11/2022.
//

import SwiftUI
import RealmSwift

struct DashboardSingleView: View {
    var id: String

    @Binding var path: [DashboardViews]
    @ObservedResults(PetDB.self) var petDb
    @ObservedResults(WeightValueDB.self) var weightDb

    var petSingleDb: PetDB? { petDb.find { $0.id == id } }
    var petWeightDb: Results<WeightValueDB> {
        weightDb
            .filter("petId == '\(id)'").sorted(by: \.date, ascending: false)
    }

    @State private var isOpenEdit = false

    var body: some View {
        if let pet = petSingleDb {
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
                                    value: petWeightDb.first?.formatted ?? pet.currentWeight?.formatted
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
                        .refreshable {
                        RealmManager().fetchPets()
                    }
                }
            }
                .navigationBarTitleDisplayMode(.inline)
        } else {
            Text(String(localized: "error_generic_message"))
        }
    }
}

struct DashboardSingleView_Previews: PreviewProvider {
    @State static var path: [DashboardViews] = []

    static var previews: some View {
        DashboardSingleView(id: PET_GOLDIE.id, path: $path)
        DashboardSingleView(id: PET_GOLDIE.id, path: $path)
            .preferredColorScheme(.dark)
    }
}
