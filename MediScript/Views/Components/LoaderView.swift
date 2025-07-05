//
//  LoaderView.swift
//  MediScript
//
//  Created by Vijin Raj on 05/07/25.
//

import Foundation
import SwiftUI

struct LoaderView: View {
    var message: String = "Please wait..."
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.3)
                .ignoresSafeArea()
            
            VStack(spacing: 16) {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .scaleEffect(1.5)
                
                Text(message)
                    .foregroundColor(.white)
                    .font(.custom(AppFonts.mediumText, size: 16))
            }
            .padding(20)
            .background(Color.black.opacity(0.8))
            .cornerRadius(12)
        }
    }
}
