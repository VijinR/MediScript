//
//  RegisterView.swift
//  MediScript
//
//  Created by Vijin Raj on 04/07/25.
//

import Foundation
import SwiftUI

import SwiftUI

struct RegisterView: View {
    @StateObject private var controller = RegisterViewController()
    @EnvironmentObject var router: AppRouter

    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()

            VStack(spacing: 0) {
                // Back button
                HStack {
                    Button(action: {
                        router.pop()
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.black)
                    }
                    Spacer()
                }
                .padding(.top, AppConstants.screenPadding)
                .padding(.horizontal, AppConstants.screenPadding)

                ScrollView {
                    VStack(alignment: .center) {
                        Text("Get Started with")
                            .font(.custom(AppFonts.boldText, size: 24))
                            .foregroundColor(.black)
                            .padding(.top, 40)

                        Text("MediScript")
                            .font(.custom(AppFonts.boldText, size: 24))
                            .foregroundColor(AppColors.primary)

                        TextField("Email", text: $controller.email)
                            .font(.custom(AppFonts.mediumText, size: 14))
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                            .padding(.top, 40)
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled(true)
                            .keyboardType(.emailAddress)

                        SecureField("Password", text: $controller.password)
                            .font(.custom(AppFonts.mediumText, size: 14))
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                            .padding(.top, 20)

                        SecureField("Confirm Password", text: $controller.confirmPassword)
                            .font(.custom(AppFonts.mediumText, size: 14))
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                            .padding(.top, 20)

                        Button(action: {
                            controller.register()
                        }) {
                            Spacer()
                            Text("REGISTER")
                            Spacer()
                        }
                        .primaryButtonStyle(isEnabled: controller.isValid)
                        .disabled(!controller.isValid)
                        .padding(.top, 30)

                        Text("OR")
                            .font(.custom(AppFonts.lightText, size: 15))
                            .foregroundColor(AppColors.lightBlackColor)
                            .padding(.top, 20)

                        Button(action: {
                            router.path.append(.login)
                        }) {
                            Text("LOGIN")
                                .font(.custom(AppFonts.mediumText, size: 16))
                                .foregroundColor(AppColors.primary)
                        }
                        .padding(.top, 10)

                    }
                    .padding(.horizontal, AppConstants.screenPadding)
                    .padding(.bottom, 20)
                }
                .ignoresSafeArea(.keyboard, edges: .bottom)

                Spacer()
            }

            if controller.isLoading {
                LoaderView()
            }
        }
        .navigationBarHidden(true)
        .hideKeyboardOnTap()
        .onAppear {
            controller.onRegisterSuccess = {
                router.path.append(.doctorUpdate)
            }
        }
    }
}
