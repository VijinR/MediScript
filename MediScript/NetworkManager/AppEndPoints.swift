//
//  AppEndPoints.swift
//  MediScript
//
//  Created by Vijin Raj on 04/07/25.
//

import Foundation

struct AppEndpoints {
    
    // Base URL
    static let baseURL = "http://147.93.114.66:9090"
    
    // Endpoints
    static let login = "/auth/login"
    static let register = "/auth/register"
    static let doctorUpdate = "/doctor/update"
    
    // Helper to construct full URL
    static func url(for path: String) -> URL? {
        return URL(string: baseURL + path)
    }
}
