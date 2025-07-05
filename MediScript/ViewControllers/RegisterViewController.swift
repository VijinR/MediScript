//
//  RegisterViewController.swift
//  MediScript
//
//  Created by Vijin Raj on 04/07/25.
//

import SwiftUI
import Combine

final class RegisterViewController: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    @Published var isLoading = false

    var onRegisterSuccess: (() -> Void)?

    var isValid: Bool {
        !email.isEmpty && ValidationHelper.isValidEmail(email) &&
        !password.isEmpty && confirmPassword == password
    }

    func register() {
        guard let url = URL(string: AppEndpoints.baseURL + AppEndpoints.register) else { return }
        
        let body: [String: Any] = [
            "username": email,
            "password": password
        ]
        
        DispatchQueue.main.async {
            self.isLoading = true
        }
        
        APIService.postRequest(url: url, body: body, responseType: GeneralResponse.self) { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                
                switch result {
                case .success(let response):
                    print("✅ Register success: \(response)")
                    // Native Toast
                    ToastView.show(message: response.message, type: .success)
                    // Call login after short delay to let user see toast
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        if(response.message == "User registered successfully!"){
                            self.loginAfterRegister()
                        }else{
                            self.isLoading = false
                        }
                    }
                    
                case .failure(let error):
                    self.isLoading = false
                    print("❌ Register error: \(error.localizedDescription)")
                    ToastView.show(message: error.localizedDescription, type: .error)
                }
            }
        }
    }

    private func loginAfterRegister() {
        guard let url = URL(string: AppEndpoints.baseURL + AppEndpoints.login) else { return }
        
        let body: [String: Any] = [
            "username": email,
            "password": password
        ]
        
        
        APIService.postRequest(url: url, body: body, responseType: LoginResponse.self) { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.isLoading = false
                
                switch result {
                case .success(let loginResponse):
                    print("✅ Login success: \(loginResponse)")
                    
                    // Save token to Keychain
                    KeychainHelper.standard.save(loginResponse.token, forKey: "accessToken")
                    KeychainHelper.standard.save(loginResponse.user.id, forKey: "userId")
                    
                    // Trigger navigation
                    self.onRegisterSuccess?()
                    
                case .failure(let error):
                    print("❌ Login error: \(error.localizedDescription)")
                    ToastView.show(message: error.localizedDescription, type: .error)
                }
            }
        }
    }
}
