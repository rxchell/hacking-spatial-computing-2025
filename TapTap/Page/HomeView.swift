//
//  HomeView.swift
//  TapTap
//
//  Created by Interactive 3D Design on 7/8/25.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismissWindow) private var dismissWindow
    
    var body: some View {
        VStack(spacing: 32) {
            Image(systemName: "hand.rays")
                .font(.system(size: 80, weight: .bold))
            
            Text("Welcome to TapTap")
                .font(.system(size: 70, weight: .bold, design: .rounded))
                .multilineTextAlignment(.center)
                .padding()
        }
        .padding(150)
        .glassBackgroundEffect()
        .onAppear {
            SoundPlayer.playSound(named: "tap")
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                dismissWindow(id: "HomeView")
                openWindow(id: "InstructionsView")
            }
        }
    }
}
