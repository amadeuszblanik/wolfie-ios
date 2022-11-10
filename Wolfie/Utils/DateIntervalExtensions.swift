//
//  DateIntervalExtensions.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 10/11/2022.
//

import Foundation

extension DateInterval {
    func toFormattedString() -> String {
        return dateIntervalFormatter().string(from: self) ?? String(localized: "date_now", comment: "Date of now")
    }
}
