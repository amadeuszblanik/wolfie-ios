//
//  DashboardView.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 08/11/2022.
//

import SwiftUI

struct DashboardView: View {
    @State private var selectedPet: ApiPetSingle = PET_GOLDIE // @TODO Refactor it later, too tired right now
    @State private var isAddOpen = false
    @State private var isPetEditOpen = false
    @State private var isAddWeightOpen = false
    @State private var isAddHealthLogOpen = false
    @State private var isEditHealthLogOpen = false
    @State private var path: [DashboardViews] = []
    @StateObject var realmDb = RealmManager()
    
    var list: some View {
        Group {
            VStack {
                ScrollView {
                    ForEach(realmDb.pets) { petSingle in
                        Button {
                            selectedPet = petSingle.asApi
                            path.append(DashboardViews.details)
                        } label: {
                            PetCardComponent(pet: petSingle.asApi)
                                .padding(.horizontal)
                                .padding(.bottom)
                        }
                    }
                }
            }
        }
    }
    
    var empty: some View {
        Group {
            Spacer()
            
            Text(String(localized: "dashboard_empty"))
                .fontWeight(.semibold)
        }
    }
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                if (realmDb.pets.isEmpty) {
                    empty
                } else {
                    list
                }
                
                Spacer()
                
                if realmDb.isAllowedToAddPet {
                    UIButton(text: String(localized: realmDb.pets.isEmpty ? "dashboard_empty_button" : "dashboard_button"), fullWidth: true) {
                        isAddOpen = true
                    }
                    .padding()
                    .sheet(isPresented: $isAddOpen) {
                        PetForm(onSuccess: { isAddOpen = false })
                    }
                }
            }
            .navigationDestination(for: DashboardViews.self) { dashboardView in
                switch (dashboardView) {
                case .details:
                    DashboardSingleView(pet: $selectedPet, path: $path)
                        .navigationTitle(selectedPet.name)
                        .toolbar {
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button(String(localized: "edit")) {
                                    isPetEditOpen = true
                                }
                            }
                        }
                        .sheet(isPresented: $isPetEditOpen) {
                            PetForm(onSuccess: { isPetEditOpen = false }, vm: PetForm.ViewModel(pet: selectedPet))
                        }
                case .weight:
                    DashboardWeightsView(
                        pet: $selectedPet,
                        vm: DashboardWeightsView.ViewModel(data: [WEIGHT_142, WEIGHT_140, WEIGHT_138])
                    )
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(String(localized: "add")) {
                                isAddWeightOpen = true
                            }
                        }
                    }
                    .sheet(isPresented: $isAddWeightOpen) {
                        WeightForm(pet: $selectedPet)
                    }
                    .navigationTitle(String(localized: "weights"))
                case .healthLog:
                    HealthLogView(
                        path: $path,
                        pet: $selectedPet,
                        vm: HealthLogView.ViewModel(data: [HEALTHLOG_0, HEALTHLOG_1, HEALTHLOG_2])
                    )
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(String(localized: "add")) {
                                isAddHealthLogOpen = true
                            }
                        }
                    }
                    .sheet(isPresented: $isAddHealthLogOpen) {
                        HealthLogForm(vm: HealthLogForm.ViewModel(pet: selectedPet))
                    }
                    .navigationTitle(String(localized: "health_log"))
                case .healthLogSingle:
                    HealthLogSingleView(
                        vm: HealthLogSingleView.ViewModel(data: HEALTHLOG_0)
                    )
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(String(localized: "edit")) {
                                isEditHealthLogOpen = true
                            }
                        }
                    }
                    .sheet(isPresented: $isEditHealthLogOpen) {
                        HealthLogForm(vm: HealthLogForm.ViewModel(pet: selectedPet, healthLog: HEALTHLOG_0))
                    }
                    .navigationTitle(String(localized: "health_log"))
                default:
                    Text(dashboardView.rawValue)
                }
            }
            .navigationTitle(String(localized: "dashboard"))
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
        DashboardView()
            .preferredColorScheme(.dark)
    }
}
