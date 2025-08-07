//
//  InstructionsView.swift
//  TapTap
//
//  Created by Interactive 3D Design on 7/8/25.
//

import SwiftUI

struct InstructionsView: View {
    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismissWindow) private var dismissWindow
    
    var body: some View {
        VStack(spacing: 32) {
            Image(systemName: "hand.rays")
                .font(.system(size: 45, weight: .bold))
            Text("Welcome to TapTap")
                .font(.system(size: 40, weight: .bold))
            
            Text("""
Tap the bubbles quickly!
⏱ The game lasts 30 seconds.
Do your best and have fun!
""")
                .font(.system(size: 30, weight: .bold))
                .multilineTextAlignment(.center)
                .padding()
            
            Button("Go!") {
                dismissWindow(id: "InstructionsView")
                // Transition to game view
                openWindow(id: "StartGameView")
            }
            .font(.system(size: 40, weight: .semibold))
            .padding(.horizontal, 50)
            .padding(.vertical, 20)
            .background(Color.black)
            .foregroundColor(.white)
            .cornerRadius(16)
        }
        .padding(40)
        .glassBackgroundEffect()
    }
}
