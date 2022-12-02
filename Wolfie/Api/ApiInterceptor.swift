//
//  ApiInterceptor.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 23/11/2022.
//

import Foundation
import Alamofire

final class ApiRefreshTokenInterceptor: RequestInterceptor {
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        print("💻 Request intercepetor adapt access token…")

        var urlRequest = urlRequest
        
        if let data = KeychainService.standard.read(service: "access-token", account: "wolfie") {
            if let accessToken = String(data: data, encoding: .utf8) {
                urlRequest.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
            }
        }

        completion(.success(urlRequest))
    }

    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        print("💻 Request intercepetor retrying…")
        
        guard let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 else {
            return completion(.doNotRetryWithError(error))
        }

        if let data = KeychainService.standard.read(service: "refresh-token", account: "wolfie") {
            if let refreshToken = String(data: data, encoding: .utf8) {
                let payload = DtoRefreshToken(refreshToken: refreshToken)
                
                postRefreshToken(payload: payload) { results in
                    switch results {
                    case .success(let response):
                        do {
                            try KeychainService.standard.save(Data(response.accessToken.utf8), service: "access-token", account: "wolfie")
                            
                            if let refreshToken = response.refreshToken {
                                try KeychainService.standard.save(Data(refreshToken.utf8), service: "refresh-token", account: "wolfie")
                            }

                            completion(.retry)
                        } catch {
                            completion(.doNotRetryWithError(error))
                        }
                    case .failure(let error):
                        completion(.doNotRetryWithError(error))
                    }
                }
            } else {
                print("💻 Request intercepetor failed to retry due to cannot parse refresh token")
                completion(.doNotRetry)
            }
        } else {
            print("💻 Request intercepetor failed to retry due to cannot read refresh token")
            completion(.doNotRetry)
        }
    }
    
    private func postRefreshToken(payload: DtoRefreshToken, completion: @escaping (Result<ApiSignIn, ApiError>) -> Void) -> DataRequest {
        let route = ApiRouter.postRefreshToken(payload)
        
        return AF.request(route).responseData() { results in
            let result = results.result
            let decoder = WolfieApi.jsonDecoder

            if let response = results.response {
                switch result {
                case .success(let success):
                    print("💻 Request intercepetor \(route.path) success with status code \(response.statusCode)")
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
                        let data = try decoder.decode(ApiSignIn.self, from: success)
                        print("💻 Request intercepetor \(route.path) successfully decoded")
                        debugPrint(data)
                        completion(.success(data))
                    } catch {
                        completion(.failure(.decoding))
                        print("💻 Request intercepetor \(route.path) failure due to decoding")
                        debugPrint(error)
                        sentryLog("Cannot decode data from request \(route.path)")
                    }
                case .failure(let error):
                    print("💻 Request intercepetor \(route.path) failure")
                    debugPrint(error)
                }
            } else {
                print("💻 Request intercepetor \(route.path) no response")
                debugPrint(results)
            }
        }
    }
}
