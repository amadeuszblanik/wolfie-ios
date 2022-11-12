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
        var breeds = [BREED_ENGLISH_POINTER, BREED_ENGLISH_SETTER, BREED_GIANT_SCHNAUZER, BREED_SCHNAUZER, BREED_MINIATURE_SCHNAUZER]
        var breedsSelectedItem: [SelectItem] {
            breeds.map { SelectItem(label: $0.localizedName, id: String($0.id)) }
        }
        
        init(pet: PetDB? = nil) {
            self.id = pet?.id
            self.name = pet?.name ?? ""
            self.kind = pet?.kind ?? PetKind.Dog
            self.breed = pet?.breed != nil ? SelectItem(label: pet!.breed!.localizedName, id: String(pet!.breed!.id)) : nil
            self.microchip = pet?.microchip ?? ""
            self.birthDate = pet?.birthDate ?? Date()
        }

        func save() -> ApiPetSingle {
            ApiPetSingle(
                id: id ?? name,
                name: name,
                kind: kind,
                image: "",
                currentWeight: nil,
                birthDate: birthDate,
                healthLog: 0,
                breed: breeds.find(predicate: { data in String(data.id) == breed?.id }),
                createdAt: Date(),
                updatedAt: Date()
            )
        }
    }
}
