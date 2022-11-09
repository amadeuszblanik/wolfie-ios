//
//  PetFormViewModel.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 09/11/2022.
//

import Foundation

extension PetForm {
    @MainActor class ViewModel: ObservableObject {
        var id: String?
        @Published var name: String
        @Published var kind: PetKind
        @Published var breed: SelectItem?
        @Published var microchip: String
        @Published var birthDate: Date
        var breeds = [BREED_ENGLISH_POINTER, BREED_ENGLISH_SETTER, BREED_GIANT_SCHNAUZER, BREED_SCHNAUZER, BREED_MINIATURE_SCHNAUZER].map { SelectItem(label: $0.localizedName, id: String($0.id)) }
        
        init(id: String? = nil, name: String = "", kind: PetKind = PetKind.Dog, breed: SelectItem? = nil, microchip: String = "", birthDate: Date = Date.now) {
            self.id = id
            self.name = name
            self.kind = kind
            self.breed = breed
            self.microchip = microchip
            self.birthDate = birthDate
        }

        func createPet() -> Void {
            print("Create pet\n\(name)\n\(kind)\n\(breed)\n\(microchip)\n\(birthDate)")
        }
    }
}
