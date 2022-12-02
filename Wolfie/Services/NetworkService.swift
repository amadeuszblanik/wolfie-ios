//
//  NetworkService.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 30/11/2022.
//

import Foundation
import Network

final class NetworkService: ObservableObject {
    let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "NetworkSerivce")

    @Published var isConnected = true

    init() {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnected = path.status == .satisfied ? true : false
            }
        }

        monitor.start(queue: queue)
    }
}
