//
//  StartGameView.swift
//  TapTap
//
//  Created by Interactive 3D Design on 7/8/25.
//

import SwiftUI

struct StartGameView: View {
    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissWindow) private var dismissWindow
    
    var body: some View {
        VStack(spacing: 32) {
            Text("Are You Ready?")
                .font(.system(size: 50, weight: .bold))
                .bold()
            
            Button("Start!") {
                Task {
                    dismissWindow(id: "StartGameView")
                    try? await openImmersiveSpace(id: "BubblesView")
                }
            }
            .font(.system(size: 40, weight: .semibold))
            .padding(.horizontal, 40)
            .padding(.vertical, 20)
            .background(Color.black)
            .foregroundColor(.white)
            .cornerRadius(16)
        }
        .padding()
    }
}
