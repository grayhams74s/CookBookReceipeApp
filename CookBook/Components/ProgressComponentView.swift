//
//  ProgressComponentView.swift
//  CookBook
//
//  Created by felix angcot jr on 3/1/26.
//

import SwiftUI
import Lottie

struct ProgressComponentView: View {
    @Binding var value: Float
    @Binding var success: Bool
    var body: some View {
        ZStack {
            Color.black.opacity(0.8)
            VStack {
                LottieView(animation: .named(success ? "Success-2" : "Free Searching Animation"))
                    .playing()
                    .looping()
                    .resizable()
                    .frame(width: 400, height: 400)
                if !success {
                    VStack {
                        ProgressView("Uploading", value: value, total:1)
                            .tint(Color.white)
                            .padding(.horizontal, 20)
                            .foregroundStyle(.white)
                    }
                    .padding(.top, -90)
                } else {
                    VStack (alignment: .center){
                        Text("You have sucessfully added a new receipe 🎉!")
                            .foregroundStyle(Color.white)
                            .font(.system(size: 24, weight: .bold))
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .padding(.top, -40)
                    .padding(.horizontal)
                }
          
                Spacer()
            }
            .padding(.top, 140)
            
    
        }
        .ignoresSafeArea()
    }
    
}

#Preview {
    ProgressComponentView(value: .constant(0.5), success: .constant(true))
}
