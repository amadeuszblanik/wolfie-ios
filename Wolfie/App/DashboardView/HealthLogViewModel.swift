//
//  HealthLogViewModel.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 11/11/2022.
//

import Foundation

extension HealthLogView {
    @MainActor class ViewModel: ObservableObject {
        @Published var data: [ApiHealthLogValue]
        
        init(data: [ApiHealthLogValue] = []) {
            self.data = data
        }
    }
}
