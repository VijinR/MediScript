//
//  MediScriptApp.swift
//  MediScript
//
//  Created by Athul Babu on 2025-06-14.
//

import SwiftUI

@main
struct MediScriptApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
