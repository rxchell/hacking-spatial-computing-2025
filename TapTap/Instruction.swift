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
                // Transition to game view
                showInstructions = false
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

struct StartGameView: View {
    @Binding var showGame: Bool
    
    var body: some View {
        VStack(spacing: 32) {
            Text("Are You Ready?")
                .font(.system(size: 50, weight: .bold))
                .bold()
            
            Button("Start!") {
                showGame = true
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

struct GameView: View {
    @Binding var showGame: Bool
    @Binding var showResults: Bool
    
    @State private var gameTimer: Timer?
    @State private var gameDuration: TimeInterval = 30
    
    var body: some View {
        VStack {
            Text("""
Don't worry :)
Just try your best and tap the bubbles.
""")
                .font(.system(size: 50, weight: .bold))
                .multilineTextAlignment(.center)
                .padding()
        }
        .onAppear() {
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
        VStack(spacing: 32) {
            Text("Great job! 🎉 Thanks for playing TapTap.")
                .font(.system(size: 50, weight: .bold))
            
            Text("=== Your TapTap Summary ===")
                .font(.system(size: 45, weight: .bold))
                .padding(.bottom)
            
            HStack {
                Image(systemName: "timer")
                    .font(.system(size: 36, weight: .bold))
                Text("Average Reaction Time: ? seconds")
                    .font(.system(size: 40, weight: .bold))
            }
            HStack {
                Image(systemName: "bubbles.and.sparkles")
                    .font(.system(size: 36, weight: .bold))
                Text("Bubbles Touched: ?")
                    .font(.system(size: 40, weight: .bold))
            }
            HStack {
                Image(systemName: "engine.emission.and.exclamationmark")
                    .font(.system(size: 36, weight: .bold))
                Text("Bubbles Missed: ?")
                    .font(.system(size: 40, weight: .bold))
            }
            HStack {
                Image(systemName: "hand.rays")
                    .font(.system(size: 36, weight: .bold))
                Text("Accuracy: ?%")
                    .font(.system(size: 40, weight: .bold))
            }
        }
        .padding(40)
    }
}

#Preview(windowStyle: .volumetric) {
    Instruction()
}
