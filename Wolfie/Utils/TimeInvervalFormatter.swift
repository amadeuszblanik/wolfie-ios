//
//  TimeInvervalFormatter.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 09/11/2022.
//

import Foundation

func timeIntervalFormatter() -> DateComponentsFormatter {
    let formatter = DateComponentsFormatter()

    formatter.unitsStyle = .full
    formatter.allowedUnits = [.year, .month]
    
    return formatter
}
