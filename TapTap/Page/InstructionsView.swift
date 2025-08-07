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
            Text("""
Tap the balls quickly!
The game lasts for 30 seconds.
Do your best and have fun :)
""")
                .font(.system(size: 66, weight: .bold, design: .rounded))
                .multilineTextAlignment(.center)
                .padding()
            
            Button("Go!") {
                dismissWindow(id: "InstructionsView")
                // Transition to game view
                openWindow(id: "StartGameView")
            }
                .font(.system(size: 80, weight: .bold, design: .rounded))
                .padding(.horizontal, 60)
                .padding(.vertical, 40)
                .background(Color.white)
                .foregroundColor(.blue)
                .cornerRadius(16)
                .contentShape(Rectangle())
                .padding(.all, 10)
                .buttonStyle(.plain)
        }
        .padding(150)
        .glassBackgroundEffect()
        .onAppear {
            SoundPlayer.playSound(named: "ball")
        }
    }
}
