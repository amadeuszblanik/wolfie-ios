//
//  JsonEncoder.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 13/11/2022.
//

import Foundation

func jsonEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    encoder.dateEncodingStrategy = .custom({ date, encoder in
        var container = encoder.singleValueContainer()
        let dateString = isoDateFormatter().string(from: date)
        try container.encode(dateString)
    })

    return encoder
}
