//
//  ApiRouter.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 13/11/2022.
//

import Foundation
import Alamofire

public enum ApiRouter: ApiConfiguration {
    case postAuthSignIn(_ body: DtoSignIn)
    case postAuthSignUp(_ body: DtoSignUp)
    case getPetsMy
    case getPetsWeights(_ petId: String)

    public var method: HTTPMethod {
        switch self {
        case .postAuthSignIn:
            return .post
        case .postAuthSignUp:
            return .post
        case .getPetsMy:
            return .get
        case .getPetsWeights:
            return .get
        }
    }
    
    public var baseUrl: String {
        return Bundle.main.infoDictionary?["ApiUrl"] as? String ?? "https://api.wolfie.app/v1"
    }
    
    public var path: String {
        switch self {
        case .postAuthSignIn:
            return "/auth/sign-in"
        case .postAuthSignUp:
            return "/auth/sign-up"
        case .getPetsMy:
            return "/pets/my"
        case .getPetsWeights(let petId):
            return "/pets/\(petId)/weight"
        }
    }
    
    public var body: Data? {
        switch self {
        case .postAuthSignIn(let body):
            let json = try? body.toData()

            return json
        case .postAuthSignUp(let body):
            let json = try? body.toData()

            return json
        default:
            return nil
        }
    }
    
    public var parameters: Parameters? {
        switch self {
//        case .getPetWeights(let last):
//            if (last != nil) {
//                var parameters = Parameters()
//                parameters["last"] = last
//
//                return parameters
//            }
//
//            return nil
        default:
            return nil
        }
    }
    
    public func asURLRequest() throws -> URLRequest {
        let urlWithPath = baseUrl + path
        
        let url = try urlWithPath.asURL()
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = method.rawValue
        
        let locale = Locale.preferredLanguages[0]
        urlRequest.addValue(locale, forHTTPHeaderField: "Accept-Language")
        
        let data = KeychainService.standard.read(service: "access-token", account: "wolfie")
        let accessToken = (data != nil) ? String(data: data!, encoding: .utf8) : nil
        
        if ((accessToken) != nil) {
            urlRequest.addValue("Bearer \(accessToken!)", forHTTPHeaderField: "Authorization")
        }
        
        if let parameters = parameters {
            var urlComponents = URLComponents(string: urlWithPath)!
            urlComponents.queryItems = []
            
            _ = parameters.map() { (key, value) in
                let item = URLQueryItem(name: key, value: value as? String)
                urlComponents.queryItems?.append(item)
            }

            urlRequest.url = urlComponents.url
        }
        
        if let body = body {
            urlRequest.httpBody = body
        }
        
        return urlRequest
    }
}
