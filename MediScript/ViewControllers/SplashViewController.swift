//
//  SplashViewController.swift
//  MediScript
//
//  Created by Vijin Raj on 22/06/25.
//

import Foundation

class SplashViewController: ObservableObject {
    @Published var isActive: Bool = false

    func startApp() {
        // Simulate a loading delay or initial setup (e.g. auth check, API ping)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.isActive = true
        }
    }
}
