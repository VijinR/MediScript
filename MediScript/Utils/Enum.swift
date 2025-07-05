//
//  Enum.swift
//  MediScript
//
//  Created by Vijin Raj on 05/07/25.
//

import Foundation

enum AppRoute: Hashable {
    case splash
    case welcome
    case login
    case register
    case doctorUpdate
    case dashboard
}

enum APIError: LocalizedError {
    case invalidData
    case custom(String)
    
    var errorDescription: String? {
        switch self {
        case .invalidData:
            return "Invalid server response."
        case .custom(let message):
            return message
        }
    }
}

enum ToastType {
    case success
    case error
}
