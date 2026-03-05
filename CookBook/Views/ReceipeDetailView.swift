//
//  ReceipeDetailView.swift
//  CookBook
//
//  Created by felix angcot jr on 2/23/26.
//

import SwiftUI

struct ReceipeDetailView: View {
    
    let receipe: Receipe
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                AsyncImage(url: URL(string: receipe.image)) { phase in
                    switch phase {
                    case .empty:
                        ZStack {
                            Color.gray.opacity(0.1)
                            ProgressView()
                        }
                        .frame(height: 350)
                        .clipped()

                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 350)
                            .clipped()

                    case .failure:
                        ZStack {
                            Color.gray.opacity(0.1)
                            Image(systemName: "photo")
                                .font(.system(size: 24))
                                .foregroundStyle(.gray)
                        }
                        .frame(height: 350)
                        .clipped()

                    @unknown default:
                        EmptyView()
                    }
                }
           
                
                HStack {
                    Text(receipe.name)
                        .foregroundStyle(.primary)
                        .font(.system(size: 20, weight: .semibold))
                    Spacer()
                    Image(systemName: "clock.fill")
                        .font(.system(size: 16))
                    Text("\(receipe.time) mins")
                        .font(.system(size: 16, weight: .semibold))
                }
                .padding(.horizontal)
                .padding(.top, 20)
                
                ScrollView {
                    Text(receipe.instructions)
                        .font(.system(size: 16))
                        .foregroundStyle(.primary)
                        .multilineTextAlignment(.leading)
                        .lineSpacing(8)
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                }
                .frame(height: 400)
            }
        }
        .ignoresSafeArea()
        
    }
}

#Preview {
    ReceipeDetailView(receipe: Receipe.mockReceipes[1])
}
