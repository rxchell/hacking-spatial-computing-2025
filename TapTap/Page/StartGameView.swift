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
                .font(.system(size: 90, weight: .bold, design: .rounded))
            
            Button("Start!") {
                Task {
                    SoundPlayer.playSound(named: "start")
                    dismissWindow(id: "StartGameView")
                    try? await openImmersiveSpace(id: "BubblesView")
                }
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
    }
}
