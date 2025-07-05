//
//  UserResponse.swift
//  MediScript
//
//  Created by Vijin Raj on 05/07/25.
//

import Foundation
struct UserResponse: Codable {
    let id: Int?
    let username: String?
    let firstName: String?
    let lastName: String?
    let specialization: String?
    let licenseNumber:String?
    let hospitalName:String?
    let contactNumber:String?
    let validated:Int?
}

