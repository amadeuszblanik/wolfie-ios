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
        @Published var weight: Float?
        @Published var date: Date
        @Published var weightUnits: WeightUnits = .Kilogram

        init(weight: ApiWeightValue? = nil) {
            self.id = weight?.id
            self.weight = weight?.raw
            self.date = weight?.date ?? Date()
        }

        func create() -> Void {
            print("Create \n\(weight)\n\(date)")
        }
        
        func update() -> Void {
            print("Update \n\(weight)\n\(date)")
        }
    }
}
