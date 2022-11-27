//
//  ApiSession.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 23/11/2022.
//

import Foundation
import Alamofire

let API_SESSION = Session(interceptor: ApiRefreshTokenInterceptor(), eventMonitors: [ APILogger() ])
