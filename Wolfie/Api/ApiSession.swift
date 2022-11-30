//
//  ApiSession.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 23/11/2022.
//

import Foundation
import Alamofire

var ApiSessionConfiguration: URLSessionConfiguration {
    let configuration = URLSessionConfiguration.default
    configuration.timeoutIntervalForRequest = 30
    configuration.timeoutIntervalForResource = 30
    return configuration
}
let ApiSession = Session(configuration: ApiSessionConfiguration, interceptor: ApiRefreshTokenInterceptor(), eventMonitors: [ APILogger() ])
