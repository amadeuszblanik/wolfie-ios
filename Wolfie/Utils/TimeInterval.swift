//
//  TimeInterval.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 09/11/2022.
//

import Foundation

extension TimeInterval {
    func toFormattedString() -> String {
        return timeIntervalFormatter().string(from: self) ?? String(localized: "date_now", comment: "Date of now")
    }
}
