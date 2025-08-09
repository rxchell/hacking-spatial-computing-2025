//
//  TextStyle.swift
//  TapTap
//
//  Created by Interactive 3D Design on 7/8/25.
//

import SwiftUI

extension Text {
    func resultLabelStyle() -> some View {
        self
            .font(.system(size: 50, weight: .bold, design: .rounded))
    }
    
    func resultValueStyle() -> some View {
        self
            .font(.system(size: 50, weight: .bold, design: .rounded))
            .foregroundColor(.blue)
            .padding(.vertical, 10)
            .padding(.horizontal, 20)
            .background(Color.white)
            .cornerRadius(16)
    }
}
