//
//  ApiConfiguration.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 13/11/2022.
//

import Foundation
import Alamofire

public protocol ApiConfiguration: URLRequestConvertible {
    var method: HTTPMethod { get }
    var baseUrl: String { get }
    var path: String { get }
    var parameters: Parameters? { get }
    var body: Data? { get }
    
    func asURLRequest() throws -> URLRequest
}
