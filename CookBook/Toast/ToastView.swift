//
//  ToastView.swift
//  NotificationBannerToastMessages
//
//  Created by Sheraz Ahmed on 13/09/2025.
//

import SwiftUI

struct ToastView: View {
    let toast: ToastMessage
    let onDismiss: () -> Void
    
    @State private var isVisible = false
    @State private var offset: CGFloat = -100
    
    var body: some View {
        HStack(spacing: 12) {
            // Icon
            Image(systemName: toast.type.icon)
                .foregroundColor(toast.type.color)
                .font(.title2)
                .fontWeight(.semibold)
            
            // Content
            VStack(alignment: .leading, spacing: 4) {
                Text(toast.title)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                
                if let message = toast.message {
                    Text(message)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                }
            }
            
            Spacer()
            
            // Dismiss button
            Button(action: onDismiss) {
                Image(systemName: "xmark")
                    .foregroundColor(.secondary)
                    .font(.caption)
                    .fontWeight(.medium)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(.regularMaterial)
                .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(toast.type.color.opacity(0.3), lineWidth: 1)
        )
        .padding(.horizontal, 16)
        .offset(y: offset)
        .opacity(isVisible ? 1 : 0)
        .onAppear {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                isVisible = true
                offset = 0
            }
            
            // Auto dismiss after duration
            DispatchQueue.main.asyncAfter(deadline: .now() + toast.duration) {
                dismissToast()
            }
        }
    }
    
    private func dismissToast() {
        withAnimation(.easeInOut(duration: 0.3)) {
            isVisible = false
            offset = toast.position == .top ? -100 : 100
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            onDismiss()
        }
    }
}

// MARK: - Toast Container View
struct ToastContainer: View {
    let toasts: [ToastMessage]
    let onDismiss: (ToastMessage) -> Void
    
    var body: some View {
        VStack {
            if toasts.contains(where: { $0.position == .top }) {
                VStack(spacing: 8) {
                    ForEach(toasts.filter { $0.position == .top }) { toast in
                        ToastView(toast: toast) {
                            onDismiss(toast)
                        }
                    }
                }
                .transition(.asymmetric(
                    insertion: .move(edge: .top).combined(with: .opacity),
                    removal: .move(edge: .top).combined(with: .opacity)
                ))
                
                Spacer()
            } else {
                Spacer()
            }
            
            
            if toasts.contains(where: { $0.position == .bottom }) {
                Spacer()
                
                VStack(spacing: 8) {
                    ForEach(toasts.filter { $0.position == .bottom }) { toast in
                        ToastView(toast: toast) {
                            onDismiss(toast)
                        }
                    }
                }
                .transition(.asymmetric(
                    insertion: .move(edge: .bottom).combined(with: .opacity),
                    removal: .move(edge: .bottom).combined(with: .opacity)
                ))
            }
        }
        .animation(.spring(response: 0.5, dampingFraction: 0.8), value: toasts.count)
    }
}

#Preview {
   
        
        ToastContainer(
            toasts: [
                ToastMessage(title: "Success!", message: "Your action was completed successfully", type: .success, position: .top),
                ToastMessage(title: "Error", message: "Something went wrong", type: .error, position: .bottom)
            ],
            onDismiss: { _ in }
        )
    
}
