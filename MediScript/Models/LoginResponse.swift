//
//  LoginResponse.swift
//  MediScript
//
//  Created by Vijin Raj on 05/07/25.
//

import Foundation
struct LoginResponse: Codable {
    let user: User
    let token: String
}

struct User: Codable {
    let roles: [String]
    let username: String
    let id: Int
}
