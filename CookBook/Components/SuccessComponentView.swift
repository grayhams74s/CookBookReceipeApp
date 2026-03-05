//
//  ProgressComponentView.swift
//  CookBook
//
//  Created by felix angcot jr on 3/1/26.
//

import SwiftUI
import Lottie

struct SuccessComponentView: View {
    var body: some View {
        ZStack {
            Color.black.opacity(0.8)
            VStack {
                LottieView(animation: .named("Searching"))
                    .playing()
                    .looping()
                    .resizable()
                    .frame(width: 400, height: 400)
                
                Text("Searching...")
                    .foregroundStyle(.white)
    
                Spacer()
            }
            .padding(.top, 240)
            
    
        }
        .ignoresSafeArea()
    }
    
}

#Preview {
    SuccessComponentView()
}
