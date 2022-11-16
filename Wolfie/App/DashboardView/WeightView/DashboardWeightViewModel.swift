//
//  DashboardWeightViewModel.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 10/11/2022.
//

import Foundation

extension DashboardWeightsView {
    @MainActor class ViewModel: ObservableObject {
        var units: WeightUnits = .Kilogram
        
        @Published var selectedEditWeight: WeightValueDB? = nil
        @Published var selectedDeleteWeight: WeightValueDB? = nil
        @Published var isLoading = false
        @Published var isError = false
        
        var errorMessage = ""

        func delete(petId: String, weight: WeightValueDB) -> Void {
            self.isLoading = true
            
            WolfieApi().deletePetsWeights(petId: petId, weightId: weight.id) { result in
                switch result {
                case .success:
                    RealmManager().fetchWeights(petId: petId)
                    
                    self.selectedDeleteWeight = nil
                case .failure(let error):
                    self.isError = true
                    
                    switch error {
                    case .server(let message):
                        self.errorMessage = message
                    default:
                        self.errorMessage = String(localized: "error_generic_message")
                    }
                }
                
                self.isLoading = false
            }
        }
    }
}
