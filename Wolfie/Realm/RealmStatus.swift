//
//  RealmStatus.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 21/12/2022.
//

import Foundation

class RealmStatus: ObservableObject {
    @Published var pets: ApiStatus = .initialized
}

