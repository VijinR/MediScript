//
//  KeychainHelper.swift
//  MediScript
//
//  Created by Vijin Raj on 05/07/25.
//

import Foundation
import Security

final class KeychainHelper {
    
    static let standard = KeychainHelper()
    private init() {}

    /// Save string value
    func save(_ value: String, forKey key: String) {
        if let data = value.data(using: .utf8) {
            save(data, forKey: key)
        }
    }

    /// Save int value
    func save(_ value: Int, forKey key: String) {
        let stringValue = String(value)
        if let data = stringValue.data(using: .utf8) {
            save(data, forKey: key)
        }
    }

    /// Read string value
    func readString(forKey key: String) -> String? {
        if let data = read(forKey: key) {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }

    /// Read int value
    func readInt(forKey key: String) -> Int? {
        if let stringValue = readString(forKey: key) {
            return Int(stringValue)
        }
        return nil
    }

    /// Delete value for key
    func delete(forKey key: String) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key
        ]
        SecItemDelete(query as CFDictionary)
    }

    // MARK: - Private internal helpers

    private func save(_ data: Data, forKey key: String) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecValueData as String: data
        ]
        SecItemDelete(query as CFDictionary)
        let status = SecItemAdd(query as CFDictionary, nil)
        if status != errSecSuccess {
            print("❌ Failed to save keychain value: \(status)")
        }
    }

    private func read(forKey key: String) -> Data? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        if status == errSecSuccess, let data = result as? Data {
            return data
        }
        return nil
    }
}
