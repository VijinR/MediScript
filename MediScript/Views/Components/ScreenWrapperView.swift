import SwiftUI

struct ScreenWrapperView<Content: View>: View {
    @EnvironmentObject var router: AppRouter
    let content: () -> Content

    var body: some View {
        NavigationStack(path: $router.path) {
            content()
                .navigationBarHidden(true)
                .navigationDestination(for: AppRoute.self) { route in
                    switch route {
                    case .splash:
                        SplashView()
                    case .welcome:
                        WelcomeView()
                    case .login:
                        LoginView()
                    case .register:
                        RegisterView()
                    case .doctorUpdate:
                        DoctorUpdateView()
                    case .dashboard:
                        DashboardView()
                    }
                }
        }
    }
}
