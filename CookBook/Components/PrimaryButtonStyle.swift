//
//  PrimaryButtonStyle.swift
//  CookBook
//
//  Created by felix angcot jr on 2/23/26.
//

import Foundation
import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .font(.system(size: 15, weight: .semibold))
            .padding(12)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .background(.black)
            .clipShape(RoundedRectangle(cornerRadius: 8))
        
    }
}
