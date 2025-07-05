import Foundation
import SwiftUI

struct SplashView: View {
    @EnvironmentObject var router: AppRouter

    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()

            VStack {
                Image(systemName: "heart.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(AppColors.primary)

                Text("MediScript")
                    .font(.custom(AppFonts.boldText, size: 30))
                    .padding(.top, 20)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                let token = KeychainHelper.standard.readString(forKey: "accessToken")
                print("token:",token ?? "")
                if token != nil {
                    router.resetToDashboard()
                } else {
                    router.resetToWelcome()
                }
            }
        }
    }
}
