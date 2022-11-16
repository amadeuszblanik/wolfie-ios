//
//  ShortDateFormatter.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 16/11/2022.
//

import Foundation

func shortDateFormatter() -> DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    formatter.locale = Locale.init(identifier: "en_US")

    return formatter
}
