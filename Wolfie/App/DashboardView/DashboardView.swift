//
//  DashboardView.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 08/11/2022.
//

import SwiftUI
import RealmSwift

struct DashboardView: View {
    @State private var isPetAddOpen = false
    @State private var isPetEditOpen = false
    @State private var isAddWeightOpen = false
    @State private var isAddHealthLogOpen = false
    @State private var isEditHealthLogOpen = false
    @State private var path: [DashboardViews] = []
    @StateObject var realmDb = RealmManager()
    @ObservedResults(PetDB.self) var petDb
    
    func handleSave() {
        isPetAddOpen = false
        isPetEditOpen = false
    }

    func handleDelete() {
        isPetAddOpen = false
        isPetEditOpen = false
        
        path.removeLast()
    }
    
    var list: some View {
        Group {
            VStack {
                Text("realmDb.pets \(petDb.count)")
                ScrollView {
                    ForEach(petDb) { petSingle in
                        Button {
                            path.append(DashboardViews.details(pet: petSingle))
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
                if (petDb.isEmpty) {
                    empty
                } else {
                    list
                }
                
                Spacer()
                
                if petDb.count <= 3 { // @TODO Load it from config
                    UIButton(
                        text: String(localized: petDb.isEmpty ? "dashboard_empty_button" : "dashboard_button"),
                        fullWidth: true
                    ) {
                        isPetAddOpen = true
                    }
                    .padding()
                    .sheet(isPresented: $isPetAddOpen) {
                        PetForm(onSave: handleSave, onDelete: handleDelete)
                    }
                }
            }
            .navigationDestination(for: DashboardViews.self) { dashboardView in
                switch (dashboardView) {
                case .details(let pet):
                    DashboardSingleView(pet: pet, path: $path)
                        .navigationTitle(pet.name)
                        .toolbar {
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button(String(localized: "edit")) {
                                    isPetEditOpen = true
                                }
                            }
                        }
                        .sheet(isPresented: $isPetEditOpen) {
                            PetForm(onSave: handleSave, onDelete: handleDelete, vm: PetForm.ViewModel(pet: pet))
                        }
//                case .weight:
//                    DashboardWeightsView(
//                        pet: PET_GOLDIE,
//                        vm: DashboardWeightsView.ViewModel(data: [WEIGHT_142, WEIGHT_140, WEIGHT_138])
//                    )
//                    .toolbar {
//                        ToolbarItem(placement: .navigationBarTrailing) {
//                            Button(String(localized: "add")) {
//                                isAddWeightOpen = true
//                            }
//                        }
//                    }
//                    .sheet(isPresented: $isAddWeightOpen) {
//                        WeightForm(pet: PET_GOLDIE)
//                    }
//                    .navigationTitle(String(localized: "weights"))
//                case .healthLog:
//                    HealthLogView(
//                        path: $path,
//                        pet: PET_GOLDIE,
//                        vm: HealthLogView.ViewModel(data: [HEALTHLOG_0, HEALTHLOG_1, HEALTHLOG_2])
//                    )
//                    .toolbar {
//                        ToolbarItem(placement: .navigationBarTrailing) {
//                            Button(String(localized: "add")) {
//                                isAddHealthLogOpen = true
//                            }
//                        }
//                    }
//                    .sheet(isPresented: $isAddHealthLogOpen) {
//                        HealthLogForm(vm: HealthLogForm.ViewModel(pet: PET_GOLDIE))
//                    }
//                    .navigationTitle(String(localized: "health_log"))
//                case .healthLogSingle:
//                    HealthLogSingleView(
//                        vm: HealthLogSingleView.ViewModel(data: HEALTHLOG_0)
//                    )
//                    .toolbar {
//                        ToolbarItem(placement: .navigationBarTrailing) {
//                            Button(String(localized: "edit")) {
//                                isEditHealthLogOpen = true
//                            }
//                        }
//                    }
//                    .sheet(isPresented: $isEditHealthLogOpen) {
//                        HealthLogForm(vm: HealthLogForm.ViewModel(pet: PET_GOLDIE, healthLog: HEALTHLOG_0))
//                    }
//                    .navigationTitle(String(localized: "health_log"))
                default:
                    Text("Not implemented yet")
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
