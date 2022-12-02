//
//  DtoDateFormatter.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 21/11/2022.
//

import Foundation

func dtoDateFormatter() -> DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    formatter.locale = Locale.init(identifier: "en_US")

    return formatter
}
