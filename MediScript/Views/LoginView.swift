import SwiftUI

struct LoginView: View {
    @StateObject private var controller = LoginViewController()
    @EnvironmentObject var router: AppRouter

    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()

            VStack(spacing: 0) {
                // Custom Back Button
                HStack {
                    Button(action: {
                        router.path.removeLast()
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.black)
                    }
                    Spacer()
                }
                .padding(.horizontal, AppConstants.screenPadding)
                .padding(.top, AppConstants.screenPadding)

                ScrollView {
                    VStack(alignment: .leading) {
                        HStack {
                            Spacer()
                            Text("Sign in to MediScript")
                                .font(.custom(AppFonts.boldText, size: 28))
                                .foregroundColor(.black)
                                .multilineTextAlignment(.center)
                            Spacer()
                        }
                        .padding(.top, 40)

                        Text("Email")
                            .font(.custom(AppFonts.mediumText, size: 16))
                            .foregroundColor(.black)
                            .padding(.top, 40)

                        TextField("", text: $controller.email)
                            .font(.custom(AppFonts.mediumText, size: 14))
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled(true)
                            .keyboardType(.emailAddress)

                        Text("Password")
                            .font(.custom(AppFonts.mediumText, size: 14))
                            .foregroundColor(.black)
                            .padding(.top, 25)

                        SecureField("", text: $controller.password)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(12)

                        Text("By logging into your account, you acknowledge and agree to our privacy policy.")
                            .font(.custom(AppFonts.lightText, size: 14))
                            .foregroundColor(AppColors.lightBlackColor)
                            .padding(.top, 10)
                    }
                    .padding(.horizontal, AppConstants.screenPadding)
                    .padding(.bottom, 20)
                }
                .ignoresSafeArea(.keyboard, edges: .bottom)
                .hideKeyboardOnTap()

                Button(action: {
                    controller.login()
                }) {
                    Spacer()
                    Text("LOGIN")
                    Spacer()
                }
                .primaryButtonStyle(isEnabled: controller.isValid)
                .disabled(!controller.isValid)
                .padding(.horizontal, AppConstants.screenPadding)
                .padding(.bottom, 30)
            }

            if controller.isLoading {
                LoaderView()
            }
        }
        .navigationBarHidden(true)
        .hideKeyboardOnTap()
        .onAppear {
            controller.onLoginSuccess = {
                router.resetToDashboard()
            }
        }
    }
}
