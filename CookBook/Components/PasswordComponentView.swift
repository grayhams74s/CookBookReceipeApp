//
//  PasswordComponentView.swift
//  CookBook
//
//  Created by felix angcot jr on 2/21/26.
//

import SwiftUI

struct PasswordComponentView: View {
    
    @Binding var showPassword: Bool
    @Binding var password: String

    
    
    var body: some View {
        if showPassword {
            TextField("Password", text: $password)
                .font(.system(size:14))
                .overlay(alignment: .trailing) {
                    Button(action: {
                        showPassword = false
                    }, label: {
                        Image(systemName: "eye.slash.fill")
                            .foregroundStyle(.black)
                            .padding(.bottom, 1)
                            .background(.clear)
                    })
                    
                }
            Rectangle()
                .fill(Color.border)
                .frame(height: 1)
                .padding(.bottom, 15)
        } else {
            SecureField("Password", text: $password)
                .font(.system(size: 14))
                .overlay(alignment: .trailing) {
                    Button(action: {
                        showPassword = true
                    }, label: {
                        Image(systemName: "eye")
                            .foregroundStyle(.black)
                            .padding(.bottom, 1)
                            .background(.clear)
                    })
                }
            Rectangle()
                .fill(Color.border)
                .frame(height: 1)
                .padding(.bottom, 15)
            
        }
    }
}

#Preview {
    return PasswordComponentView(showPassword: .constant(false), password: .constant(""))
}
