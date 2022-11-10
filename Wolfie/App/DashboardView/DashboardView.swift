//
//  DashboardView.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 08/11/2022.
//

import SwiftUI

struct DashboardView: View {
    @State private var isAddOpen = false
    @State private var path: [DashboardViews] = []
    @StateObject var vm = ViewModel();
    
    var list: some View {
        Group {
            VStack {
                UIJumbotron(
                    header: String(localized: "dashboard_header")
                )
                
                ScrollView {
                    ForEach(vm.petsList) { petSingle in
                        Button {
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
            VStack {
                UIJumbotron(header: String(localized: "dashboard_header"))
            }
            
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
                    DashboardSingleView(pet: PET_GOLDIE)
                default:
                    Text(dashboardView.rawValue)
                }
            }
            .navigationBarHidden(true)
            .navigationTitle(String(localized: "dashboard_header"))
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
