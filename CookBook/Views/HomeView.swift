//
//  HomeView.swift
//  CookBook
//

import SwiftUI

struct HomeView: View {
    
    @Environment(SessionManager.self) var sessionManager: SessionManager
    @State var viewModel = HomeViewModel()
    
    fileprivate func ReceipeRow(receipe: Receipe) -> some View {
        VStack (alignment: .leading) {
            Image(receipe.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: itemWidth, height: itemHeight)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .clipped()
            Text(receipe.name)
                .lineLimit(1)
                .font(.system(size: 15, weight: .bold))
                .foregroundStyle(.black)
        }
    }
    
    fileprivate func HorizontalList(receipe: Receipe) -> some View {
        HStack (spacing: 20){
            AsyncImage(url: URL(string: receipe.image)) { phase in
                switch phase {
                case .empty:
                    ZStack {
                        Color.gray.opacity(0.1)
                        ProgressView()
                    }
                    .frame(width: 150, height: 150)
                    .clipShape(RoundedRectangle(cornerRadius: 8))

                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 150, height: 150)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .clipped()

                case .failure:
                    ZStack {
                        Color.gray.opacity(0.1)
                        Image(systemName: "photo")
                            .font(.system(size: 24))
                            .foregroundStyle(.gray)
                    }
                    .frame(width: 150, height: 150)
                    .clipShape(RoundedRectangle(cornerRadius: 8))

                @unknown default:
                    EmptyView()
                }
            }
            VStack (alignment: .leading, spacing: 4){
                HStack (spacing: 4){
                    Image(systemName: "frying.pan.fill")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundStyle(.white)
                    Text("\(Int(receipe.time)) mins")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundStyle(.white)
                    
                }
                .frame(width: 90, height: 28)
                .background(.black.opacity(0.9))
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0.0, y: 5)
                
                HStack{
                    Text(receipe.name)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(.black)
                    Spacer()
                }
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 12)
        .background(Color.white) // ensure a solid background if needed
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
        )
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .padding(.horizontal)
        .padding(.bottom, 10)

        

    }
    
    
    fileprivate func FloatingButton() -> some View {
        Button(action: {
            viewModel.showAddReceipeView = true
        }, label: {
            HStack {
                Text("Make Receipe")
                Image(systemName: "frying.pan.fill")
            }
            .font(.system(size: 15, weight: .semibold))
            .padding(12)
            .foregroundStyle(.white)
            .frame(maxWidth: 200)
            .frame(height: 60)
            .background(.black.opacity(0.9))
            .clipShape(RoundedRectangle(cornerRadius: 30))
            .shadow(color: Color.black.opacity(0.5), radius: 10, x: 0.0, y: 10)
        })
    }
    
    
    let columns = [
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10)
    ]
    
    let spacing: CGFloat = 5
    let padding: CGFloat = 5
    
    var itemWidth: CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        return (screenWidth - (spacing * 2) - (padding * 2)) / 3
    }
    
    var itemHeight: CGFloat {
        return CGFloat(1.5) * itemWidth
    }
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    ScrollView(.vertical) {
                        LazyVStack (spacing: 5) {
                            ForEach(viewModel.receipes) { receipe in
                                NavigationLink {
                                    ReceipeDetailView(receipe: receipe)
                                } label : {
                                    HorizontalList(receipe: receipe)
                                }
                          
                            }
                        }
                    }
                    .refreshable {
                        Task {
                            await viewModel.fetchReceipes()
                        }
                    }
                    Spacer()
                    
                    FloatingButton()
                }
                .toolbar(content: {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button (action: {
                            viewModel.showSignOutAlert = true
                        }, label: {
                            Image(systemName: "gearshape.fill")
                                .foregroundStyle(.black)
                        })
                        .shadow(color: .black.opacity(0.3), radius: 5)
                    }
                })
                .alert("Are you sure you would like to sign out?", isPresented: $viewModel.showSignOutAlert) {
                    
                    Button("Sign Out", role: .destructive) {
                        if viewModel.signOut() {
                            sessionManager.sessionState = .loggedOut
                        }

                    }
                    
                    Button ("Cancel", role: .cancel) {
                        viewModel.showSignOutAlert = false
                    }
                }
                if viewModel.isFetching {
                    SuccessComponentView()
                }
            }
        }
        .task {
            await viewModel.fetchReceipes()
        }
        .sheet(isPresented:  $viewModel.showAddReceipeView, content: {
            AddReceipeView()
        })
        
    }
    
}

#Preview {
    HomeView()
        .environment(SessionManager())
}


