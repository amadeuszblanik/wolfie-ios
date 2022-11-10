//
//  DashboardViewModel.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 09/11/2022.
//

import Foundation

extension DashboardView {
    @MainActor class ViewModel: ObservableObject {
        @Published var petsList: [ApiPetSingle] {
            didSet {
                // @TODO Will fetch data from config
                isAllowedToAddPet = self.petsList.count < 3
            }
        }
        @Published var isAllowedToAddPet = true
        
        init(petList: [ApiPetSingle] = []) {
            self.petsList = petList
        }
        
        func devAddPet() -> Void {
            petsList.append([PET_GOLDIE, PET_TESTIE].randomElement()!)
        }
        
        func devClearPetList() -> Void {
            petsList = []
        }
        
        func devRemoveLastPet() -> Void {
            if (petsList.isEmpty) {
                return
            }
            
            petsList.removeLast()
        }
    }
}
