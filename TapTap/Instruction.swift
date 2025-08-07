//
//  Instruction.swift
//  TapTap
//
//  Created by Interactive 3D Design on 6/8/25.
//

import SwiftUI

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
                .multilineTextAlignment(.center)
                .padding()

            Button("Go!") {
                showInstructions = false
            }
            .font(.title2)
            .padding()
            .foregroundColor(.white)
            .background(Color.blue)
            .cornerRadius(12)
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
                .onAppear {
                    startCountdown()
                }
        }
    }

    func startCountdown() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if countdown > 1 {
                countdown -= 1
            } else {
                timer.invalidate()
                showGame = true
            }
        }
    }
}

struct ResultsView: View {
    var body: some View {
        VStack(spacing: 24) {
            Text("Game Over! Results appear here.")
                .font(.title)
                .bold()
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
