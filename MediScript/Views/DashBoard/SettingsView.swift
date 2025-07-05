//
//  SettingsView.swift
//  MediScript
//
//  Created by Vijin Raj on 05/07/25.
//

import Foundation
import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var router: AppRouter

    var body: some View {
        VStack(spacing: 30) {
            Text("Settings")
                .font(.largeTitle)
                .fontWeight(.bold)

            Button(action: {
                logoutUser()
            }) {
                Text("LOGOUT")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(12)
            }
            .padding(.horizontal, 40)

            Spacer()
        }
        .padding(.top, 50)
    }

    private func logoutUser() {
        // Clear Keychain values
        KeychainHelper.standard.delete(forKey: "accessToken")
        KeychainHelper.standard.delete(forKey: "userId")

        // Reset navigation to Welcome
        router.resetToWelcome()
    }
}
