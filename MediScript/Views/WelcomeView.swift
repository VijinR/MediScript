import SwiftUI

struct WelcomeView: View {
    @EnvironmentObject var router: AppRouter

    var body: some View {
        VStack {
            Spacer()

            // Title
            Text("Digital Prescriptions\nSimplified !")
                .font(.custom(AppFonts.boldText, size: 30))
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
                    .foregroundColor(AppColors.primary)
            }
            .padding(.top, 40)

            // Description text
            Text("Empowering doctors with seamless, fully digital prescription solutions for efficient care.")
                .font(.custom(AppFonts.regularText, size: 15))
                .foregroundColor(AppColors.lightBlackColor)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
                .padding(.top, 30)

            Spacer()

            // Login button
            Button {
                router.path.append(.login)
            } label: {
                HStack {
                    Spacer()
                    Text("LOGIN")
                    Spacer()
                }
            }
            .primaryButtonStyle()
            .padding(.bottom, 15)
            .padding(.horizontal, AppConstants.screenPadding)

            // Register text button
            Button {
                router.path.append(.register)
            } label: {
                Text("REGISTER")
                    .font(.custom(AppFonts.mediumText, size: 16))
                    .foregroundColor(AppColors.primary)
            }
            .padding(.bottom, 30)
        }
        .background(Color.white)
        .navigationBarHidden(true)
    }
}
