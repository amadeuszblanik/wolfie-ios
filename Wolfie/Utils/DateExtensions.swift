//
//  DateExtensions.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 09/11/2022.
//

import Foundation

extension Date {
    func toToday() -> TimeInterval {
        return Date().timeIntervalSinceReferenceDate - self.timeIntervalSinceReferenceDate
    }
    
    func toFormatted() -> String { // @TODO DEPRECATED
        return dateFormatter().string(from: self)
    }
    
    var asFormatted: String {
        return dateFormatter().string(from: self)
    }
    
    func toFormattedWithTime() -> String { // @TODO DEPRECATED
        return dateFormatter(dateStyle: .medium, timeStyle: .short).string(from: self)
    }
    
    var asFormattedWithTime: String {
        return dateFormatter(dateStyle: .medium, timeStyle: .short).string(from: self)
    }
    
    var asFormattedMedium: String {
        return dateFormatter(dateStyle: .medium).string(from: self)
    }
    
    func toFormattedShort() -> String { // @TODO DEPRECATED
        return dateFormatter(dateStyle: .short).string(from: self)
    }
    
    var asFormattedShort: String {
        return dateFormatter(dateStyle: .short).string(from: self)
    }
    
    func toFormattedChart() -> String { // @TODO DEPRECATED
        return dateFormatter(dateStyle: nil, dateFormat: "dd MMM").string(from: self)
    }
    
    var asFormattedChart: String {
        return dateFormatter(dateStyle: nil, dateFormat: "dd MMM").string(from: self)
    }
    
    var asDtoDateFormatted: String {
        return dtoDateFormatter().string(from: self)
    }
}
