//
//  DashboardView.swift
//  MediScript
//
//  Created by Vijin Raj on 05/07/25.
//

import Foundation
import SwiftUI

struct DashboardView: View {
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                .tag(0)

            PrescriptionView()
                .tabItem {
                    Image(systemName: "doc.text.fill")
                    Text("Prescription")
                }
                .tag(1)

            SettingsView()
                .tabItem {
                    Image(systemName: "gearshape.fill")
                    Text("Settings")
                }
                .tag(2)
        }
        .accentColor(AppColors.primary)
        .navigationBarHidden(true)
    }
}
