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
    @StateObject var vm = ViewModel();
    
    var list: some View {
        Group {
            VStack {
                ScrollView {
                    ForEach(vm.petsList) { petSingle in
                        Button {
                            selectedPet = petSingle
                            path.append(DashboardViews.details)
                        } label: {
                            PetCardComponent(pet: petSingle)
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
                if (vm.petsList.isEmpty) {
                    empty
                } else {
                    list
                }
                
                Spacer()
                
                if vm.isAllowedToAddPet {
                    UIButton(text: String(localized: vm.petsList.isEmpty ? "dashboard_empty_button" : "dashboard_button"), fullWidth: true) {
                        isAddOpen = true
                    }
                    .padding()
                    .sheet(isPresented: $isAddOpen) {
                        PetForm()
                    }
                }
                
                #if DEBUG
                ScrollView(.horizontal) {
                    HStack {
                        Button("Add pet") {
                            vm.devAddPet()
                        }
                        .buttonStyle(.bordered)
                        
                        Button("Clear pet list") {
                            vm.devClearPetList()
                        }
                        .buttonStyle(.bordered)
                        
                        Button("Remove last pet") {
                            vm.devRemoveLastPet()
                        }
                        .buttonStyle(.bordered)
                        .disabled(vm.petsList.isEmpty)
                    }
                    .padding(.horizontal)
                }
                #endif
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
                            PetForm(vm: PetForm.ViewModel(pet: selectedPet))
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
                        Text("Not implemented yet")
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
                        Text("Not implemented yet")
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
        DashboardView(vm: DashboardView.ViewModel(petList: [PET_GOLDIE]))
        DashboardView(vm: DashboardView.ViewModel(petList: [PET_GOLDIE]))
            .preferredColorScheme(.dark)
    }
}
