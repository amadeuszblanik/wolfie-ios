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
    func postSignInWithApple(body: DtoSignWithApple, completion: @escaping (Result<ApiSignIn, ApiError>) -> Void)
    func postRefreshToken(body: DtoRefreshToken, completion: @escaping (Result<ApiSignIn, ApiError>) -> Void)
    func postFcmToken(body: DtoFcmToken, completion: @escaping (Result<ApiCommonResponse, ApiError>) -> Void)
    func postTestNotification(completion: @escaping (Result<ApiCommonResponse, ApiError>) -> Void)
    func getProfile(completion: @escaping (Result<ApiUser, ApiError>) -> Void)
    func deleteUser(body: DtoDeleteUser, completion: @escaping (Result<ApiMessage, ApiError>) -> Void)
    func deleteDeactivateUser(body: DtoDeleteUser, completion: @escaping (Result<ApiMessage, ApiError>) -> Void)
    func getConfig(completion: @escaping (Result<ApiConfig, ApiError>) -> Void)
    func getPetsMy(completion: @escaping (Result<[ApiPetSingle], ApiError>) -> Void)
    func postPets(body: DtoPet, completion: @escaping (Result<ApiPetSingle, ApiError>) -> Void)
    func putPets(petId: String, body: DtoPetUpdate, completion: @escaping (Result<ApiPetSingle, ApiError>) -> Void)
    func deletePets(petId: String, completion: @escaping (Result<ApiMessage, ApiError>) -> Void)
    func getPetsWeights(petId: String, completion: @escaping (Result<[ApiWeightValue], ApiError>) -> Void)
    func postPetsWeights(petId: String, body: DtoWeight, completion: @escaping (Result<ApiWeightValue, ApiError>) -> Void)
    func patchPetsWeights(petId: String, weightId: String, body: DtoWeight, completion: @escaping (Result<ApiWeightValue, ApiError>) -> Void)
    func deletePetsWeights(petId: String, weightId: String, completion: @escaping (Result<ApiMessage, ApiError>) -> Void)
    func getPetsHealthLog(petId: String, completion: @escaping (Result<[ApiHealthLogValue], ApiError>) -> Void)
    func postPetsHealthLog(petId: String, body: DtoHealthLog, completion: @escaping (Result<ApiHealthLogValue, ApiError>) -> Void)
    func patchPetsHealthLog(petId: String, healthLogId: String, body: DtoHealthLog, completion: @escaping (Result<ApiHealthLogValue, ApiError>) -> Void)
    func deletePetsHealthLog(petId: String, healthLogId: String, completion: @escaping (Result<ApiMessage, ApiError>) -> Void)
    func getBreeds(completion: @escaping (Result<[ApiBreed], ApiError>) -> Void)
    func getMedicines(completion: @escaping (Result<[ApiShortMedicineValue], ApiError>) -> Void)
}

public final class WolfieApi {
    @discardableResult
    private func performRequest<T: Decodable>(route: ApiRouter, decoder: JSONDecoder = WolfieApi.jsonDecoder, completion: @escaping (Result<T, ApiError>) -> Void) -> DataRequest {
        return ApiSession.request(route).validate().responseData() { results in
            let result = results.result

            if let response = results.response {
                UserDefaults.standard.set(false, forKey: "IS_OFFLINE")

                switch result {
                case .success(let success):
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
                        print("???? Request \(route.path) successfully decoded")
                        debugPrint(data)
                        completion(.success(data))
                    } catch {
                        completion(.failure(.decoding))
                        print("???? Request \(route.path) failure due to decoding")
                        debugPrint(error)
                        sentryLog("Cannot decode data from request \(route.path)")
                    }
                case .failure(let error):
                    print("???? Request \(route.path) failure")
                    debugPrint(error)

                    do {
                        let errorMessage = try decoder.decode(ApiErrorMessage.self, from: results.data!)

                        completion(.failure(.server(message: errorMessage.message)))
                    } catch {
                        completion(.failure(.unknownError))
                        sentryLog("Cannot connect to API [\(response.statusCode)]", code: response.statusCode)
                    }
                }
            } else {
                print("???? Request \(route.path) no response")
                debugPrint(results.result)
                UserDefaults.standard.set(true, forKey: "IS_OFFLINE")
                completion(.failure(.unknownError))
            }
        }
    }

    static var jsonDecoder: JSONDecoder {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .formatted(jsonDateFormatter())
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase

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

    func postSignInWithApple(body: DtoSignWithApple, completion: @escaping (Result<ApiSignIn, ApiError>) -> Void) {
        performRequest(route: .postAuthSignWithApple(body), completion: completion)
    }

    func postRefreshToken(body: DtoRefreshToken, completion: @escaping (Result<ApiSignIn, ApiError>) -> Void) {
        performRequest(route: .postRefreshToken(body), completion: completion)
    }

    func postFcmToken(body: DtoFcmToken, completion: @escaping (Result<ApiCommonResponse, ApiError>) -> Void) {
        performRequest(route: .postFcmToken(body), completion: completion)
    }

    func postTestNotification(completion: @escaping (Result<ApiCommonResponse, ApiError>) -> Void) {
        performRequest(route: .postTestNotification, completion: completion)
    }

    func getProfile(completion: @escaping (Result<ApiUser, ApiError>) -> Void) {
        performRequest(route: .getProfile, completion: completion)
    }

    func deleteUser(body: DtoDeleteUser, completion: @escaping (Result<ApiMessage, ApiError>) -> Void) {
        performRequest(route: .deleteUser(body), completion: completion)
    }

    func deleteDeactivateUser(body: DtoDeleteUser, completion: @escaping (Result<ApiMessage, ApiError>) -> Void) {
        performRequest(route: .deleteDeactivateUser(body), completion: completion)
    }

    func getConfig(completion: @escaping (Result<ApiConfig, ApiError>) -> Void) {
        performRequest(route: .getConfig, completion: completion)
    }

    func getPetsMy(completion: @escaping (Result<[ApiPetSingle], ApiError>) -> Void) {
        performRequest(route: .getPetsMy, completion: completion)
    }

    func postPets(body: DtoPet, completion: @escaping (Result<ApiPetSingle, ApiError>) -> Void) {
        performRequest(route: .postPets(body), completion: completion)
    }

    func putPets(petId: String, body: DtoPetUpdate, completion: @escaping (Result<ApiPetSingle, ApiError>) -> Void) {
        performRequest(route: .putPets(petId, body: body), completion: completion)
    }

    func deletePets(petId: String, completion: @escaping (Result<ApiMessage, ApiError>) -> Void) {
        performRequest(route: .deletePets(petId), completion: completion)
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

    func deletePetsWeights(petId: String, weightId: String, completion: @escaping (Result<ApiMessage, ApiError>) -> Void) {
        performRequest(route: .deletePetsWeights(petId, weightId: weightId), completion: completion)
    }

    func getPetsHealthLog(petId: String, completion: @escaping (Result<[ApiHealthLogValue], ApiError>) -> Void) {
        performRequest(route: .getPetsHealthLog(petId), completion: completion)
    }

    func postPetsHealthLog(petId: String, body: DtoHealthLog, completion: @escaping (Result<ApiHealthLogValue, ApiError>) -> Void) {
        performRequest(route: .postPetsHealthLog(petId, body: body), completion: completion)
    }

    func patchPetsHealthLog(petId: String, healthLogId: String, body: DtoHealthLog, completion: @escaping (Result<ApiHealthLogValue, ApiError>) -> Void) {
        performRequest(route: .patchPetsHealthLog(petId, healthLogId: healthLogId, body: body), completion: completion)
    }

    func deletePetsHealthLog(petId: String, healthLogId: String, completion: @escaping (Result<ApiMessage, ApiError>) -> Void) {
        performRequest(route: .deletePetsHealthLog(petId, healthLogId: healthLogId), completion: completion)
    }

    func getBreeds(completion: @escaping (Result<[ApiBreed], ApiError>) -> Void) {
        performRequest(route: .getBreeds, completion: completion)
    }

    func getMedicines(completion: @escaping (Result<[ApiShortMedicineValue], ApiError>) -> Void) {
        performRequest(route: .getMedicines, completion: completion)
    }
}
