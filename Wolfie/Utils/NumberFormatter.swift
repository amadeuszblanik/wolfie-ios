//
//  NumberFormatter.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 14/11/2022.
//

import Foundation

func numberFormatter(_ style: NumberFormatter.Style = .none, zeroSymbol: String? = nil) -> NumberFormatter {
    let formatter = NumberFormatter()
    formatter.locale = Locale.current

    if style == .decimal {
        formatter.numberStyle = .decimal
        formatter.generatesDecimalNumbers = true
    } else {
        formatter.numberStyle = style
    }
    formatter.zeroSymbol = zeroSymbol

    return formatter
}
