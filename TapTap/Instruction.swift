//
//  Instruction.swift
//  TapTap
//
//  Created by Interactive 3D Design on 6/8/25.
//

import SwiftUI
//import RealityKit
//import RealityKitContent

struct Instruction: View {
    @State private var showInstructions = true
    @State private var showGame = false
    

    var body: some View {
        if showInstructions {
            InstructionsView(showInstructions: $showInstructions)
        } else if showGame {
                GameView()
        } else {
                StartGameView(showGame: $showGame)
        }
    }
}

struct InstructionsView: View {
    @Binding var showInstructions: Bool
    
    var body: some View {
        VStack(spacing: 24) {
            Text("Tap Tap Instructions")
                .font(.title)
                .fontWeight(.bold)
            
            Text("""
Touch the bubbles as fast as you can!
The game lasts for 30 seconds.
Tap the Go! button to start.
""")
                .font(.body)
                .multilineTextAlignment(.center)
                .padding()
            
            Button(action: {
                // Transition to game view
                showInstructions = false
            }) {
                Text("Go!")
                    .font(.title2)
                    .padding()
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
        }
        .padding()
        .glassBackgroundEffect()
    }
}

struct StartGameView: View {
    @Binding var showGame: Bool
    @State private var countdown = 3
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Get Ready!")
                .font(.largeTitle)
            
            Text("\(countdown)")
                .font(.system(size: 72))
                .bold()
                .onAppear(){
                    startCountdown()
                }
        }
    }
    
    func startCountdown() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            // Closure executed every time interval
            if countdown > 1 {
                countdown -= 1
            } else {
                timer.invalidate()
                showGame = true
            }
        }
    }
}

struct GameView: View {
    var body: some View {
        Text("Game Started! Bubbles appears here.")
            .font(.title2)
    }
}

#Preview(windowStyle: .volumetric) {
    Instruction()
}
