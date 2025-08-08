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
                SoundPlayer.playSound(named: "go")
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
                .onAppear {
                    SoundPlayer.playSound(named: "ball")
                    print("playing sound in onappear")
                }
                .task {
                    try? await Task.sleep(for: .seconds(3))
                    openWindow(id: "StartGameView")
                    try? await Task.sleep(for: .seconds(0.5))
                    dismissWindow(id: "InstructionsView")
                }
        }
        .padding(150)
        .glassBackgroundEffect()
    }
}
