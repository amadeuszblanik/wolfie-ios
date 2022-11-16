//
//  StringExtensions.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 11/11/2022.
//

import Foundation

extension String {
    var asDate: Date {
        dateFormatter().date(from: self) ?? Date()
    }
    
    var asShortDate: Date {
        shortDateFormatter().date(from: self) ?? Date()
    }
}
