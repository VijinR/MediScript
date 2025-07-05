//
//  UIApplication.swift
//  MediScript
//
//  Created by Vijin Raj on 04/07/25.
//

import SwiftUI

extension UIApplication {
    var safeAreaInsets: UIEdgeInsets {
        (connectedScenes.first as? UIWindowScene)?
            .windows
            .first { $0.isKeyWindow }?
            .safeAreaInsets ?? .zero
    }
}
