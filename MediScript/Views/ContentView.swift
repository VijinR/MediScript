//
//  ContentView.swift
//  MediScript
//
//  Created by Vijin Raj on 22/06/25.
//

import SwiftUI
import SwiftUI

struct WelcomeView: View {
    var body: some View {
        NavigationView {
            VStack {
                Spacer()

                // Title
                Text("Digital Prescriptions\nSimplified !")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 30)

                // Image card
                ZStack {
                    Color(.systemGray6)
                        .frame(width: 220, height: 220)
                        .cornerRadius(20)

                    Image(systemName: "heart.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .foregroundColor(Color.green)
                }
                .padding(.top, 40)

                // Description text
                Text("Empowering doctors with seamless, fully digital prescription solutions for efficient care.")
                    .font(.system(size: 16))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
                    .padding(.top, 30)

                Spacer()

                // Login button
                NavigationLink(destination: Text("Login Screen")) {
                    Text("LOGIN")
                        .font(.system(size: 18, weight: .bold))
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(30)
                        .padding(.horizontal, 30)
                }
                .padding(.bottom, 15)

                // Register text button
                NavigationLink(destination: Text("Register Screen")) {
                    Text("REGISTER")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(Color.green)
                }
                .padding(.bottom, 30)
            }
            .background(Color.white)
            .ignoresSafeArea()
        }
        .navigationViewStyle(StackNavigationViewStyle()) // For iPad/iPhone consistency
    }
}
