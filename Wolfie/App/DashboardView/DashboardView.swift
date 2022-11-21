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
    
    init() {
        RealmManager().fetchPets()
    }
    
    func handleSave() {
        isPetAddOpen = false
        isPetEditOpen = false

        path = []
    }

    func handleDelete() {
        isPetAddOpen = false
        isPetEditOpen = false
        
        path = []
    }
    
    var list: some View {
        Group {
            VStack {
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
                .refreshable {
                    realmDb.fetchPets()
                }
            }
        }
    }
    
    var empty: some View {
        Group {
            Spacer()
            
            Text(String(localized: "dashboard_empty"))
                .fontWeight(.semibold)
            
            UIButton(text: String(localized: "refresh")) {
                realmDb.fetchPets()
            }
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
                
                if petDb.count < 3 { // @TODO Load it from config
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
                    DashboardSingleView(id: pet.id, path: $path)
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
                case .weight(let pet):
                    DashboardWeightsView(pet: pet)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(String(localized: "add")) {
                                isAddWeightOpen = true
                            }
                        }
                    }
                    .sheet(isPresented: $isAddWeightOpen) {
                        WeightForm(vm: WeightForm.ViewModel(
                            pet: pet,
                            onSuccess: {
                                isAddWeightOpen = false
                            }
                        ))
                    }
                    .navigationTitle(String(localized: "weights"))
                case .healthLog(let pet):
                    HealthLogView(
                        pet: pet,
                        path: $path
                    )
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(String(localized: "add")) {
                                isAddHealthLogOpen = true
                            }
                        }
                    }
                    .sheet(isPresented: $isAddHealthLogOpen) {
                        HealthLogForm(vm: HealthLogForm.ViewModel(
                            pet: pet,
                            onSuccess: {
                                isAddHealthLogOpen = false
                            }
                        ))
                    }
                    .navigationTitle(String(localized: "health_log"))
                case .healthLogSingle(let pet, let healthLog):
                    HealthLogSingleView(
                        id: healthLog.id
                    )
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(String(localized: "edit")) {
                                isEditHealthLogOpen = true
                            }
                        }
                    }
                    .sheet(isPresented: $isEditHealthLogOpen) {
                        HealthLogForm(vm: HealthLogForm.ViewModel(
                            pet: pet,
                            data: healthLog,
                            onSuccess: {
                                isEditHealthLogOpen = false
                            }
                        ))
                    }
                    .navigationTitle(String(localized: "health_log"))
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
