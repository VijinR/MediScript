//
//  DoctorUpdateView.swift
//  MediScript
//
//  Created by Vijin Raj on 04/07/25.
//

import Foundation
import SwiftUI

struct DoctorUpdateView: View {
    @StateObject private var controller = DoctorUpdateController()
    @EnvironmentObject var router: AppRouter

    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()

            VStack(spacing: 0) {
                HStack {
                    Button(action: {
//                        router.pop()
                    }) {
//                        Image(systemName: "chevron.left")
//                            .foregroundColor(.black)
                    }
                    Spacer()
                }
                .padding(.top, AppConstants.screenPadding)
                .padding(.horizontal, AppConstants.screenPadding)

                ScrollView {
                    VStack(alignment: .leading) {
                        Text("Please Fill your Details")
                            .font(.custom(AppFonts.boldText, size: 24))
                            .foregroundColor(.black)
                            .padding(.top, 40)

                        Group {
                            TextField("First name as per ID", text: $controller.firstName)
                            TextField("Last name as per ID", text: $controller.lastName)
                            TextField("Hospital name", text: $controller.hospital)
                            TextField("Qualification", text: $controller.qualification)
                            TextField("Enter 8 digit doctor registration number", text: $controller.registrationNumber)
                        }
                        .font(.custom(AppFonts.mediumText, size: 14))
                        .foregroundColor(.black)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                        .autocorrectionDisabled(true)
                        .padding(.top, 20)

                        HStack(spacing: 10) {
                            Text("+91")
                                .font(.custom(AppFonts.mediumText, size: 14))
                                .padding()
                                .frame(width: 70)
                                .background(Color(.systemGray6))
                                .cornerRadius(12)

                            TextField("Phone Number", text: $controller.phoneNumber)
                                .font(.custom(AppFonts.mediumText, size: 14))
                                .foregroundColor(.black)
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(12)
                                .autocorrectionDisabled(true)
                        }
                        .padding(.top, 20)

                        Button(action: {
                            controller.submit()
                        }) {
                            Spacer()
                            Text("SUBMIT")
                            Spacer()
                        }
                        .primaryButtonStyle(isEnabled: controller.isValid)
                        .disabled(!controller.isValid)
                        .padding(.top, 40)

                        Spacer()
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
            controller.onUpdateSuccess = {
                router.resetToDashboard()
            }
        }
    }
}
