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
    public func postSignIn(body: DtoSignIn, completion: @escaping (Result<ApiSignIn, ApiError>) -> Void) {
        performRequest(route: .postAuthSignIn(body), completion: completion)
    }
    
    func postSignUp(body: DtoSignUp, completion: @escaping (Result<ApiMessage, ApiError>) -> Void) {
        performRequest(route: .postAuthSignUp(body), completion: completion)
    }
}
