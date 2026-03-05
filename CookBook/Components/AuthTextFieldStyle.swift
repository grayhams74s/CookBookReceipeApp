//
//  AuthTextFieldStyle.swift
//  CookBook
//
//  Created by felix angcot jr on 2/21/26.
//

import SwiftUI

struct AuthTextFieldStyle: TextFieldStyle {
    
    func _body(configuration: TextField<Self._Label>) -> some View {

            configuration
                .font(.system(size:14))
                .textInputAutocapitalization(.never)
            Rectangle()
                .fill(Color.border)
                .frame(height: 1)
                .padding(.bottom, 15)
        
    }
}

