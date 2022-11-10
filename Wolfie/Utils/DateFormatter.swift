//
//  DateFormatter.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 09/11/2022.
//

import Foundation

func dateFormatter(dateStyle: DateFormatter.Style? = .long, dateFormat: String? = nil, timeStyle: DateFormatter.Style? = DateFormatter.Style.none) -> DateFormatter {
    let formatter = DateFormatter()
    if (dateStyle != nil) {
        formatter.dateStyle = dateStyle!
    }
    if (dateFormat != nil) {
        formatter.dateFormat = dateFormat!
    }
    
    if (timeStyle != nil) {
        formatter.timeStyle = timeStyle!
    }
    
    return formatter
}
