//
//  HealthLogViewModel.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 11/11/2022.
//

import Foundation

extension HealthLogView {
    @MainActor class ViewModel: ObservableObject {
        @Published var isLoading = false
        @Published var selectedDeleteHealthLog: HealthLogDB? = nil
        
        func delete(petId: String, healthLogId: String) -> Void {
            self.isLoading = true

            WolfieApi().deletePetsHealthLog(petId: petId, healthLogId: healthLogId) { result in
                RealmManager().fetchHealthLog(petId: petId)
                
                self.isLoading = false
            }
        }
    }
}
