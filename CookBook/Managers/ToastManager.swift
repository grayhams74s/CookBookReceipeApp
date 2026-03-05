


import SwiftUI
import UIKit

// MARK: - Toast Window Manager
class ToastWindowManager {
    static let shared = ToastWindowManager()
    
    private var window: UIWindow?
    private var hostingController: UIHostingController<ToastContainerWrapper>?
    
    private init() {}
    
    func setup() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return
        }
        
        let window = UIWindow(windowScene: windowScene)
        window.windowLevel = .alert + 1
        window.backgroundColor = .clear
        window.isUserInteractionEnabled = false
        
        let containerView = ToastContainerWrapper()
        let hostingController = UIHostingController(rootView: containerView)
        hostingController.view.backgroundColor = .clear
        
        window.rootViewController = hostingController
        window.isHidden = false
        
        self.window = window
        self.hostingController = hostingController
    }
}

// MARK: - Toast Container Wrapper
struct ToastContainerWrapper: View {
    @StateObject private var toastManager = ToastManager.shared
    
    var body: some View {
        ToastContainer(
            toasts: toastManager.toasts,
            onDismiss: { toast in
                toastManager.dismissToast(toast)
            }
        )
    }
}

// MARK: - Toast Manager
class ToastManager: ObservableObject {
    static let shared = ToastManager()
    
    @Published var toasts: [ToastMessage] = []
    
    private init() {
        // Setup window on first access
        DispatchQueue.main.async {
            ToastWindowManager.shared.setup()
        }
    }
    
    // MARK: - Public Methods
    
    @MainActor
    func display(_ toast: ToastMessage) {
        withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
            toasts.append(toast)
        }
    }
    
    // MARK: - Convenience Methods
    
    @MainActor
    private func createAndDisplay(type: ToastType, title: String, message: String? = nil, duration: Double = 3.0, position: ToastPosition = .top) {
        let toast = ToastMessage(
            title: title,
            message: message,
            type: type,
            duration: duration,
            position: position
        )
        display(toast)
    }
    
    @MainActor
    func showSuccess(title: String, message: String? = nil, duration: Double = 3.0, position: ToastPosition = .top) {
        createAndDisplay(type: .success, title: title, message: message, duration: duration, position: position)
    }
    
    @MainActor
    func showError(title: String, message: String? = nil, duration: Double = 3.0, position: ToastPosition = .top) {
        createAndDisplay(type: .error, title: title, message: message, duration: duration, position: position)
    }
    
    @MainActor
    func showWarning(title: String, message: String? = nil, duration: Double = 3.0, position: ToastPosition = .top) {
        createAndDisplay(type: .warning, title: title, message: message, duration: duration, position: position)
    }
    
    @MainActor
    func showInfo(title: String, message: String? = nil, duration: Double = 3.0, position: ToastPosition = .top) {
        createAndDisplay(type: .info, title: title, message: message, duration: duration, position: position)
    }
    
    @MainActor
    func dismissToast(_ toast: ToastMessage) {
        withAnimation(.easeInOut(duration: 0.3)) {
            toasts.removeAll { $0.id == toast.id }
        }
    }
    
    @MainActor
    func dismissAllToasts() {
        withAnimation(.easeInOut(duration: 0.3)) {
            toasts.removeAll()
        }
    }
    
}
