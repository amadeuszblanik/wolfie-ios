//
//  ApiLogger.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 27/11/2022.
//

import Foundation
import Alamofire

final class APILogger: EventMonitor {
    init() {
        print("💻 APILogger initialized…")
    }

    func requestDidFinish(_ request: Request) {
        let body = request.request.flatMap { $0.httpBody.map { String(decoding: $0, as: UTF8.self) } } ?? "Empty"
        let message = """
        💻 APILogger().requestDidFinish::START
        💻 Request: \(request)
        💻 Body Data: \(body)
        💻 APILogger().requestDidFinish::END
        """

        print(message)
    }

    func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
        guard let data = response.data else { return }
        if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) {
            let message = """
        💻 APILogger().request::START
        💻 Request: \(request)
        💻 Request data: \(json)
        💻 APILogger().request::END
        """
            print(message)
        }
    }
}
