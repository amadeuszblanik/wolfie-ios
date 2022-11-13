//
//  EncodableExtensions.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 13/11/2022.
//

import Foundation

extension Encodable {
    func toData(_ encoder: JSONEncoder = jsonEncoder()) throws -> Data {
        let data = try encoder.encode(self)
        
        return data
    }
}
