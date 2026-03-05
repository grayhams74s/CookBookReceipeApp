//
//  LoadingViewComponent.swift
//  CookBook
//
//  Created by felix angcot jr on 2/26/26.
//

import SwiftUI

struct LoadingViewComponent: View {
    var body: some View {
        ZStack {
            Color.black.opacity(0.7)
            HStack {
                Text("Creating your account...")
                    .foregroundStyle(.white)
                ProgressView()
                    .tint(Color.white)
            }
         
        }
        .ignoresSafeArea()
    }
}

#Preview {
    LoadingViewComponent()
}
