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
    case postRefreshToken(_ body: DtoRefreshToken)
    case getProfile
    case deleteUser(_ body: DtoDeleteUser)
    case deleteDeactivateUser(_ body: DtoDeleteUser)
    case getConfig
    case getPetsMy
    case postPets(_ body: DtoPet)
    case putPets(_ petId: String, body: DtoPetUpdate)
    case deletePets(_ petId: String)
    case getPetsWeights(_ petId: String)
    case postPetsWeights(_ petId: String, body: DtoWeight)
    case patchPetsWeights(_ petId: String, weightId: String, body: DtoWeight)
    case deletePetsWeights(_ petId: String, weightId: String)
    case getPetsHealthLog(_ petId: String)
    case postPetsHealthLog(_ petId: String, body: DtoHealthLog)
    case patchPetsHealthLog(_ petId: String, healthLogId: String, body: DtoHealthLog)
    case deletePetsHealthLog(_ petId: String, healthLogId: String)
    case getBreeds
    case getMedicines

    public var method: HTTPMethod {
        switch self {
        case .postAuthSignIn:
            return .post
        case .postAuthSignUp:
            return .post
        case .postRefreshToken:
            return .post
        case .getProfile:
            return .get
        case .getConfig:
            return .get
        case .deleteUser:
            return .delete
        case .deleteDeactivateUser:
            return .delete
        case .getPetsMy:
            return .get
        case .postPets:
            return .post
        case .putPets:
            return .put
        case .deletePets:
            return .delete
        case .getPetsWeights:
            return .get
        case .postPetsWeights:
            return .post
        case .patchPetsWeights:
            return .patch
        case .deletePetsWeights:
            return .delete
        case .getPetsHealthLog:
            return .get
        case .postPetsHealthLog:
            return .post
        case .patchPetsHealthLog:
            return .patch
        case .deletePetsHealthLog:
            return .delete
        case .getBreeds:
            return .get
        case .getMedicines:
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
        case .postRefreshToken:
            return "/auth/refresh-token"
        case .getProfile:
            return "/auth/profile"
        case .getConfig:
            return "/config"
        case .deleteUser:
            return "/auth/delete-account"
        case .deleteDeactivateUser:
            return "/auth/deactivate-account"
        case .getPetsMy:
            return "/pets/my"
        case .postPets:
            return "/pets/add"
        case .putPets(let petId, _):
            return "/pets/\(petId)"
        case .deletePets(let petId):
            return "/pets/\(petId)"
        case .getPetsWeights(let petId):
            return "/pets/\(petId)/weight"
        case .postPetsWeights(let petId, _):
            return "/pets/\(petId)/weight"
        case .patchPetsWeights(let petId, let weightId, _), .deletePetsWeights(let petId, let weightId):
            return "/pets/\(petId)/weight/\(weightId)"
        case .getPetsHealthLog(let petId):
            return "/pets/\(petId)/health-log"
        case .postPetsHealthLog(let petId, _):
            return "/pets/\(petId)/health-log"
        case .patchPetsHealthLog(let petId, let healthLogId, _):
            return "/pets/\(petId)/health-log/\(healthLogId)"
        case .deletePetsHealthLog(let petId, let healthLogId):
            return "/pets/\(petId)/health-log/\(healthLogId)"
        case .getBreeds:
            return "/breed"
        case .getMedicines:
            return "/medicine"
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
        case .postRefreshToken(let body):
            let json = try? body.toData()

            return json
        case .deleteUser(let body):
            let json = try? body.toData()

            return json
        case .deleteDeactivateUser(let body):
            let json = try? body.toData()

            return json
        case .postPets(let body):
            let json = try? body.toData()

            return json
        case .putPets(_, let body):
            let json = try? body.toData()

            return json
        case .postPetsWeights(_, let body):
            let json = try? body.toData()

            return json
        case .patchPetsWeights(_, _, let body):
            let json = try? body.toData()

            return json
        case .postPetsHealthLog(_, let body):
            let json = try? body.toData()

            return json
        case .patchPetsHealthLog(_, _, let body):
            let json = try? body.toData()

            return json
        default:
            return nil
        }
    }

    public var parameters: Parameters? {
        switch self {
        case .getMedicines:
            var parameters = Parameters()
            parameters["long"] = false

            return parameters
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
