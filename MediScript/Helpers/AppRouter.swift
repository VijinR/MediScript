//
//  AppRouter.swift
//  MediScript
//
//  Created by Vijin Raj on 05/07/25.
//

import Foundation
import SwiftUI
final class AppRouter: ObservableObject {
    @Published var path: [AppRoute] = []
    
    func pop() {
        if !path.isEmpty {
            path.removeLast()
        }
    }
    
    func resetToDashboard() {
        path = [.dashboard]
    }
    
    func resetToWelcome() {
        path = [.welcome]
    }
    
}
