//
//  ToastView.swift
//  MediScript
//
//  Created by Vijin Raj on 05/07/25.
//

import Foundation
import UIKit

final class ToastView {
    
    static func show(message: String, type: ToastType = .success, duration: TimeInterval = 2.0) {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else { return }
        
        let toastLabel = UILabel()
        toastLabel.text = message
        toastLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        toastLabel.textAlignment = .center
        toastLabel.numberOfLines = 0
        toastLabel.alpha = 0.0
        toastLabel.layer.cornerRadius = 12
        toastLabel.clipsToBounds = true
        toastLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Set colors based on type
        switch type {
        case .success:
            toastLabel.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.95)
            toastLabel.textColor = .white
        case .error:
            toastLabel.backgroundColor = UIColor.systemRed.withAlphaComponent(0.95)
            toastLabel.textColor = .white
        }

        window.addSubview(toastLabel)

        // Constraints
        let bottomConstraint = toastLabel.bottomAnchor.constraint(equalTo: window.bottomAnchor, constant: 100)
        
        NSLayoutConstraint.activate([
            toastLabel.leadingAnchor.constraint(equalTo: window.leadingAnchor, constant: 40),
            toastLabel.trailingAnchor.constraint(equalTo: window.trailingAnchor, constant: -40),
            toastLabel.heightAnchor.constraint(equalToConstant: 50),
            bottomConstraint
        ])

        window.layoutIfNeeded()

        // Animate up into view
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseOut, animations: {
            toastLabel.alpha = 1.0
            bottomConstraint.constant = -60
            window.layoutIfNeeded()
        }) { _ in
            // Animate down and remove after delay
            UIView.animate(withDuration: 0.4, delay: duration, options: .curveEaseIn, animations: {
                toastLabel.alpha = 0.0
                bottomConstraint.constant = 100
                window.layoutIfNeeded()
            }, completion: { _ in
                toastLabel.removeFromSuperview()
            })
        }
    }
}
