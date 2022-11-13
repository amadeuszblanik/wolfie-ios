//
//  ApiError.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 13/11/2022.
//

import Foundation

public enum ApiError: Error {
    case requestFailed
    case enconding
    case unknownError
    case decoding
    case authentication
    case server(message: String)
}
