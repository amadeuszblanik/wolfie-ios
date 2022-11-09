//
//  DashboardViewModel.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 09/11/2022.
//

import Foundation

extension DashboardView {
    @MainActor class ViewModel: ObservableObject {
        var petsList: [ApiPetSingle]
        
        init(petList: [ApiPetSingle] = []) {
            self.petsList = petList
        }
    }
}
