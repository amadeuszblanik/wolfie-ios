//
//  HealthLogViewModel.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 11/11/2022.
//

import Foundation

extension HealthLogView {
    @MainActor class ViewModel: ObservableObject {
        func delete(_ id: String) -> Void {
            print("Delete \(id)")
        }
    }
}
