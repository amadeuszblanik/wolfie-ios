//
//  WeightFormViewModel.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 10/11/2022.
//

import Foundation

extension WeightForm {
    @MainActor class ViewModel: ObservableObject {
        var id: String?
        @Published var pet: PetDB?
        @Published var weight: Float? = nil
        @Published var date: Date = Date()
        @Published var weightUnits: WeightUnits = .Kilogram // @TODO Config

        func create() -> Void {
            print("Create \n\(weight)\n\(date)")
        }
        
        func update() -> Void {
            print("Update \(id)\n\(weight)\n\(date)")
        }
    }
}
