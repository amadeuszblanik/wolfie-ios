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
    @ObservedResults(ConfigDB.self) var configDb

    var canAddNewPets: Bool {
        if let userPetsAllowed = configDb.first?.userPetsAllowed {
            return petDb.count < userPetsAllowed
        }

        return false
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
            GeometryReader { geometry in
                ScrollView(.vertical) {
                    VStack {
                        Spacer()

                        Text(String(localized: "dashboard_empty"))
                            .fontWeight(.semibold)
                        Spacer()
                    }
                    .frame(width: geometry.size.width)
                    .frame(minHeight: geometry.size.height)
                }
            }
            .refreshable {
                realmDb.fetchPets()
            }
        }
    }

    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                switch realmDb.petsStatus {
                case .initialized:
                    Spacer()
                    ProgressView()
                        .onAppear {
                            realmDb.fetchPets()
                        }
                case .fetching:
                    PetCardSkeletonComponent()
                        .padding(.horizontal)
                        .padding(.bottom)
                case .success:
                    if !petDb.isEmpty {
                        list
                    } else {
                        empty
                    }
                case .failed:
                    Spacer()
                    UIStatus(realmDb.petsErrorMessage, onTryAgain: realmDb.fetchPets)
                        .padding(.horizontal)
                }

                Spacer()

                if canAddNewPets {
                    UIButton(
                        text: String(localized: petDb.isEmpty ? "dashboard_empty_button" : "dashboard_button"),
                        fullWidth: true
                    ) {
                        isPetAddOpen = true
                    }
                        .padding()
                        .sheet(isPresented: $isPetAddOpen) {
                            PetForm(vm: PetForm.ViewModel(onSave: handleSave, onDelete: handleDelete))
                    }
                }
            }
                .navigationDestination(for: DashboardViews.self) { dashboardView in
                switch dashboardView {
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
                            PetForm(vm: PetForm.ViewModel(pet: pet, onSave: handleSave, onDelete: handleDelete))
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
                }
            }
                .navigationTitle(String(localized: "dashboard"))
                .navigationBarTitleDisplayMode(.large)
                .onAppear {
                    realmDb.fetchPets()
                }
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        TabView {
            DashboardView()
                .tabItem {
                    Label(AppViews.dashboard.label, systemImage: AppViews.dashboard.systemImage)
                }
        }
        TabView {
            DashboardView()
                .tabItem {
                    Label(AppViews.dashboard.label, systemImage: AppViews.dashboard.systemImage)
                }
        }
        .preferredColorScheme(.dark)
    }
}
