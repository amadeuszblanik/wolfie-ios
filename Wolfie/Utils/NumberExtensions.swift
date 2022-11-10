//
//  NumberExtensions.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 10/11/2022.
//

import Foundation

extension Double {
    var formattedString: String {
        return String(format: "%.2f", self)
    }
}

extension Float {
    var formattedString: String {
        return String(format: "%.2f", self)
    }
}
