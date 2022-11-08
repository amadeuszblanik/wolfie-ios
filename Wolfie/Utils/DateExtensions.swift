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
    
    func toFormatted() -> String {
        return dateFormatter().string(from: self)
    }
    
    func toFormattedWithTime() -> String {
        return dateFormatter(timeStyle: .short).string(from: self)
    }
    
    func toFormattedShort() -> String {
        return dateFormatter(dateStyle: .short).string(from: self)
    }
    
    func toFormattedChart() -> String {
        return dateFormatter(dateStyle: nil, dateFormat: "dd MMM").string(from: self)
    }
}
