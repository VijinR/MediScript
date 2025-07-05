//
//  PrimaryButton.swift
//  MediScript
//
//  Created by Vijin Raj on 22/06/25.
//

import Foundation
import SwiftUI

struct PrimaryButtonStyle: ViewModifier {
    var isEnabled: Bool = true

    func body(content: Content) -> some View {
        content
            .font(.custom(AppFonts.boldText, size: 18))
            .frame(maxWidth: .infinity)
            .padding()
            .background(isEnabled ? AppColors.primary : Color.gray)
            .foregroundColor(.white)
            .cornerRadius(15)
            .padding(.horizontal, 2)
    }
}

extension View {
    func primaryButtonStyle(isEnabled: Bool = true) -> some View {
        self.modifier(PrimaryButtonStyle(isEnabled: isEnabled))
    }
}
