//
//  ToastMessage.swift
//  NotificationBannerToastMessages
//
//  Created by Sheraz Ahmed on 13/09/2025.
//

import SwiftUI

// MARK: - Toast Message Types
enum ToastType: CaseIterable {
    case success
    case error
    case warning
    case info
    
    var color: Color {
        switch self {
        case .success:
            return .green
        case .error:
            return .red
        case .warning:
            return .orange
        case .info:
            return .blue
        }
    }
    
    var icon: String {
        switch self {
        case .success:
            return "checkmark.circle.fill"
        case .error:
            return "xmark.circle.fill"
        case .warning:
            return "exclamationmark.triangle.fill"
        case .info:
            return "info.circle.fill"
        }
    }
    
}

// MARK: - Toast Position
enum ToastPosition: CaseIterable {
    case top
    case bottom
    
}

// MARK: - Toast Message Model
struct ToastMessage: Identifiable {
    let id = UUID()
    let title: String
    let message: String?
    let type: ToastType
    let duration: Double
    let position: ToastPosition
    
    init(title: String, message: String? = nil, type: ToastType = .info, duration: Double = 3.0, position: ToastPosition = .top) {
        self.title = title
        self.message = message
        self.type = type
        self.duration = duration
        self.position = position
    }
}
