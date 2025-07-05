//
//  MediScriptApp.swift
//  MediScript
//
//  Created by Vijin Raj on 22/06/25.
//

import SwiftUI

@main
struct MediScriptApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject var router = AppRouter()

    var body: some Scene {
        WindowGroup {
            ScreenWrapperView {
                SplashView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
            .environmentObject(router)
        }
    }
}

