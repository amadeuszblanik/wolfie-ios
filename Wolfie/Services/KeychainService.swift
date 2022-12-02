//
//  KeychainService.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 13/11/2022.
//

import Foundation

enum KeychainError: Error {
    case cannotSave(OSStatus)
}

final class KeychainService {
    static let standard = KeychainService()

    private init() { }

    func save(_ data: Data, service: String, account: String) throws {
        let isExists = self.read(service: service, account: account)

        let query = [
            kSecValueData: data,
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account,
        ] as CFDictionary

        let queryUpdate = [
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecClass: kSecClassGenericPassword,
        ] as CFDictionary

        let attributesToUpdate = [kSecValueData: data] as CFDictionary

        let status = isExists == nil ? SecItemAdd(query, nil) : SecItemUpdate(queryUpdate as CFDictionary, attributesToUpdate)

        if status != errSecSuccess {
            let message = """
            🔑 Keychain Error
            🔑 Status: \(status)
            🔑 Description: \(status.description)
            🔑 Is exists: \(isExists == nil  ? "true" : "false")
            """
            print(message)
            sentryLog("Cannot save data to Keychain \(status)")

            throw KeychainError.cannotSave(status)
        }
    }

    func read(service: String, account: String) -> Data? {
        let query = [
            kSecReturnData: true,
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account,
        ] as CFDictionary

        var result: AnyObject?
        SecItemCopyMatching(query, &result)

        return (result as? Data)
    }

    func delete(service: String, account: String) -> Void {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account,
        ] as CFDictionary

        SecItemDelete(query)
    }
}
