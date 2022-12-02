//
//  JsonDateFormatter.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 13/11/2022.
//

import Foundation

func jsonDateFormatter() -> DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    formatter.locale = Locale.init(identifier: "en_US")

    return formatter
}
