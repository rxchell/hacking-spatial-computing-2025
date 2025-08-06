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
    @State private var showResults = false

    var body: some View {
        if showInstructions {
            InstructionsView(showInstructions: $showInstructions)
        } else if showGame {
            GameView(showGame: $showGame, showResults: $showResults)
        } else if showResults {
            ResultsView()
        } else {
            StartGameView(showGame: $showGame)
        }
    }
}

struct InstructionsView: View {
    @Binding var showInstructions: Bool
    
    var body: some View {
        VStack(spacing: 24) {
            Text("TapTap Instructions")
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
            // use timer if needed
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
    @Binding var showGame: Bool
    @Binding var showResults: Bool
    
    @State private var gameTimer: Timer?
    @State private var gameDuration: TimeInterval = 30
    //@State private var gameStartTime: Date?
    
    var body: some View {
        VStack {
            Text("Game Started! Bubbles appear here.")
                .font(.title)
                .bold()
        }
        .onAppear() {
                //gameStartTime = Date()
                gameTimer = Timer.scheduledTimer(withTimeInterval: gameDuration, repeats: false) { _ in
                    // do something, ignore input
                    endGame()
                }
            }
    }
    
    func endGame() {
        gameTimer?.invalidate()
        showGame = false
        showResults = true
    }
}

struct ResultsView: View {
    var body: some View {
        VStack(spacing: 24) {
            Text("Game Over! Results appear here.")
                .font(.title)
                .bold()
            Text("=== Your TapTap Summary ===")
            HStack {
                Image(systemName: "timer")
                Text("Average Reaction Time: ? seconds")
            }
            HStack {
                Image(systemName: "bubbles.and.sparkles")
                Text("Bubbles Touched: ?")
            }
            HStack {
                Image(systemName: "engine.emission.and.exclamationmark")
                Text("Bubbles Missed: ?")
            }
            HStack {
                Image(systemName: "hand.rays")
                Text("Accuracy: ?%")
            }
        }
        .padding()
    }
}

#Preview(windowStyle: .volumetric) {
    Instruction()
}
