//
//  ApiService.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 13/11/2022.
//

import Foundation
import Alamofire

protocol WolfieApiProtocol {
    func postSignIn(body: DtoSignIn, completion: @escaping (Result<ApiSignIn, ApiError>) -> Void)
    func postSignUp(body: DtoSignUp, completion: @escaping (Result<ApiMessage, ApiError>) -> Void)
    func getPetsMy(completion: @escaping (Result<[ApiPetSingle], ApiError>) -> Void)
    func getPetsWeights(petId: String, completion: @escaping (Result<[ApiWeightValue], ApiError>) -> Void)
    func postPetsWeights(petId: String, body: DtoWeight, completion: @escaping (Result<ApiWeightValue, ApiError>) -> Void)
    func patchPetsWeights(petId: String, weightId: String, body: DtoWeight, completion: @escaping (Result<ApiWeightValue, ApiError>) -> Void)
}

public final class WolfieApi {
    @discardableResult
    private func performRequest<T: Decodable>(route: ApiRouter, decoder: JSONDecoder = WolfieApi.jsonDecoder, completion: @escaping (Result<T, ApiError>) -> Void) -> DataRequest {
        print("💻 Request \(route.path)")
        
        return AF.request(route).responseData() { results in
            let result = results.result

            if let response = results.response {
                switch result {
                case .success(let success):
                    print("💻 Request \(route.path) success with status code \(response.statusCode)")
                    debugPrint(success)
                    
                    if (response.statusCode == 401) {
                        completion(.failure(.authentication))
                    }
                    
                    if (response.statusCode >= 300) {
                        do {
                            let errorMessage = try decoder.decode(ApiErrorMessage.self, from: success)
                            completion(.failure(.server(message: errorMessage.message)))
                        } catch {
                            completion(.failure(.unknownError))
                            sentryLog("Cannot connect to API [\(response.statusCode)]", code: response.statusCode)
                        }
                        
                        return
                    }
                    
                    do {
                        let data = try decoder.decode(T.self, from: success)
                        completion(.success(data))
                    } catch {
                        completion(.failure(.decoding))
                        debugPrint(error)
                        sentryLog("Cannot decode data from request \(route.path)")
                    }
                case .failure(let error):
                    print("💻 Request \(route.path) failure")
                    debugPrint(error)
                }
            } else {
                print("💻 Request \(route.path) no response")
                debugPrint(results)
            }
        }
    }
    
    static var jsonDecoder: JSONDecoder {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .formatted(jsonDateFormatter())
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase;
        
        return jsonDecoder
    }
}

extension WolfieApi: WolfieApiProtocol {
    func postSignIn(body: DtoSignIn, completion: @escaping (Result<ApiSignIn, ApiError>) -> Void) {
        performRequest(route: .postAuthSignIn(body), completion: completion)
    }
    
    func postSignUp(body: DtoSignUp, completion: @escaping (Result<ApiMessage, ApiError>) -> Void) {
        performRequest(route: .postAuthSignUp(body), completion: completion)
    }
    
    func getPetsMy(completion: @escaping (Result<[ApiPetSingle], ApiError>) -> Void) {
        performRequest(route: .getPetsMy, completion: completion)
    }
    
    func getPetsWeights(petId: String, completion: @escaping (Result<[ApiWeightValue], ApiError>) -> Void) {
        performRequest(route: .getPetsWeights(petId), completion: completion)
    }
    
    func postPetsWeights(petId: String, body: DtoWeight, completion: @escaping (Result<ApiWeightValue, ApiError>) -> Void) {
        performRequest(route: .postPetsWeights(petId, body: body), completion: completion)
    }
    
    func patchPetsWeights(petId: String, weightId: String, body: DtoWeight, completion: @escaping (Result<ApiWeightValue, ApiError>) -> Void) {
        performRequest(route: .patchPetsWeights(petId, weightId: weightId, body: body), completion: completion)
    }
}
