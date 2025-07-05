//
//  DoctorUpdateController.swift
//  MediScript
//
//  Created by Vijin Raj on 04/07/25.
//

import Foundation
import SwiftUI

class DoctorUpdateController: ObservableObject {
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var hospital: String = ""
    @Published var qualification: String = ""
    @Published var registrationNumber: String = ""
    @Published var phoneNumber: String = ""
    
    @Published var isLoading = false

    var onUpdateSuccess: (() -> Void)?

    var isValid: Bool {
        !firstName.isEmpty &&
        !lastName.isEmpty &&
        !hospital.isEmpty &&
        !qualification.isEmpty &&
        registrationNumber.count == 8 &&
        phoneNumber.count >= 8
    }

    func submit() {
        guard let url = URL(string: AppEndpoints.baseURL + AppEndpoints.doctorUpdate) else { return }
        guard let userId = KeychainHelper.standard.readInt(forKey: "userId") else {
            ToastView.show(message: "User Id missing", type: .error)
            return
        }
        
        DispatchQueue.main.async {
            self.isLoading = true
        }

        let body: [String: Any] = [
            "id": userId,
            "firstName": firstName,
            "lastName": lastName,
            "specialization": qualification,
            "licenseNumber": registrationNumber,
            "hospitalName": hospital,
            "contactNumber": "+91" + phoneNumber
        ]

        APIService.postRequest(
            url: url,
            body: body,
            responseType: UserResponse.self
        ) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.isLoading = false
                switch result {
                case .success(let response):
                    print("✅ Doctor details updated: \(response)")
                    ToastView.show(message: "Details updated successfully", type: .success)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                        self.onUpdateSuccess?()
                    }

                case .failure(let error):
                    print("❌ Error: \(error.localizedDescription)")
                    ToastView.show(message: error.localizedDescription, type: .error)
                }
            }
        }
    }
}
