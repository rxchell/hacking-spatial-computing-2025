//
//  Instruction.swift
//  TapTap
//
//  Created by Interactive 3D Design on 6/8/25.
//

import SwiftUI
import AVFoundation

struct Instruction: View {
    @State private var showHome = true
    @State private var showInstructions = false
    @State private var showGame = false
    @State private var showResults = false

    var body: some View {
        Group {
            if showHome {
                HomePageView(showHome: $showHome, showInstructions: $showInstructions)
            } else if showInstructions {
                InstructionsView(showInstructions: $showInstructions)
            } else if showGame {
                GameView(showGame: $showGame, showResults: $showResults)
            } else if showResults {
                ResultsView()
            } else {
                StartGameView(showGame: $showGame)
            }
        }
        .onAppear {
            SoundPlayer.playBackgroundMusic(named: "background")
        }
    }
}

struct HomePageView: View {
    @Binding var showHome: Bool
    @Binding var showInstructions: Bool
    
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
                showHome = false
                showInstructions = true
            }
        }
    }
}

struct InstructionsView: View {
    @Binding var showInstructions: Bool
    
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
                showInstructions = false
            }
                .font(.system(size: 60, weight: .semibold, design: .rounded))
                .padding(.horizontal, 60)
                .padding(.vertical, 30)
                .background(Color.black)
                .foregroundColor(.white)
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

struct StartGameView: View {
    @Binding var showGame: Bool
    
    var body: some View {
        VStack(spacing: 32) {
            Text("Are You Ready?")
                .font(.system(size: 65, weight: .bold, design: .rounded))
            
            Button("Start!") {
                SoundPlayer.playSound(named: "start")
                showGame = true
            }
                .font(.system(size: 60, weight: .semibold, design: .rounded))
                .padding(.horizontal, 60)
                .padding(.vertical, 30)
                .background(Color.black)
                .foregroundColor(.white)
                .cornerRadius(16)
                .contentShape(Rectangle())
                .padding(.all, 10)
                .buttonStyle(.plain)
        }
        .padding(150)
        .glassBackgroundEffect()
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
Just try your best and tap the balls.
""")
                .font(.system(size: 65, weight: .bold, design: .rounded))
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
            Text("""
Great job 🎉 
Thank you for playing TapTap
""")
                .font(.system(size: 65, weight: .bold, design: .rounded))
                .multilineTextAlignment(.center)
                .padding()
            
            Text("=== Your TapTap Summary ===")
                .font(.system(size: 60, weight: .bold, design: .rounded))
                .padding(.bottom)
            
            HStack(spacing: 20) {
                Image(systemName: "timer")
                    .font(.system(size: 50, weight: .bold))
                    .frame(width: 60)
                Text("Average Reaction Time: ? seconds")
                    .font(.system(size: 50, weight: .bold, design: .rounded))
                    .multilineTextAlignment(.leading)
            }
            HStack(spacing: 20) {
                Image(systemName: "hand.rays")
                    .font(.system(size: 50, weight: .bold))
                    .frame(width: 60)
                Text("Balls Touched: ?")
                    .font(.system(size: 50, weight: .bold, design: .rounded))
                    .multilineTextAlignment(.leading)
            }
            HStack(spacing: 20) {
                Image(systemName: "engine.emission.and.exclamationmark")
                    .font(.system(size: 50, weight: .bold))
                    .frame(width: 60)
                Text("Balls Missed: ?")
                    .font(.system(size: 50, weight: .bold, design: .rounded))
                    .multilineTextAlignment(.leading)
            }
            HStack(spacing: 20) {
                Image(systemName: "checkmark.circle")
                    .font(.system(size: 50, weight: .bold))
                    .frame(width: 60)
                Text("Accuracy: ?%")
                    .font(.system(size: 50, weight: .bold, design: .rounded))
                    .multilineTextAlignment(.leading)
            }
        }
        .padding(150)
        .glassBackgroundEffect()
        .onAppear {
            SoundPlayer.playSound(named: "great")
        }
    }
}

#Preview(windowStyle: .volumetric) {
    Instruction()
}
