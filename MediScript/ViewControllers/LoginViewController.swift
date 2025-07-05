//
//  LoginViewController.swift
//  MediScript
//
//  Created by Vijin Raj on 22/06/25.
//

import Foundation
import Combine

final class LoginViewController: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var isLoading = false

    var onLoginSuccess: (() -> Void)?

    var isValid: Bool {
        !email.isEmpty && !password.isEmpty
    }

    func login() {
        guard let url = URL(string: AppEndpoints.baseURL + AppEndpoints.login) else { return }

        let body: [String: Any] = [
            "username": email,
            "password": password
        ]

        DispatchQueue.main.async {
            self.isLoading = true
        }

        APIService.postRequest(url: url, body: body, responseType: LoginResponse.self) { [weak self] result in
            guard let self = self else { return }

            DispatchQueue.main.async {
                self.isLoading = false

                switch result {
                case .success(let loginResponse):
                    print("✅ Login success: \(loginResponse)")
                    KeychainHelper.standard.save(loginResponse.token, forKey: "accessToken")
                    KeychainHelper.standard.save(loginResponse.user.id, forKey: "userId")
                    self.onLoginSuccess?()

                case .failure(let error):
                    print("❌ Login error: \(error.localizedDescription)")
                    ToastView.show(message: error.localizedDescription, type: .error)
                }
            }
        }
    }
}
