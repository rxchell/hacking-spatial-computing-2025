//
//  Instruction.swift
//  TapTap
//
//  Created by Interactive 3D Design on 6/8/25.
//

import SwiftUI
import AVFoundation

struct Instruction: View {
    @State private var showInstructions = true
    @State private var showGame = false
    @State private var showResults = false

    var body: some View {
        Group {
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
        .onAppear {
            SoundPlayer.playBackgroundMusic(named: "background")
        }
    }
}

class SoundPlayer {
    static var backgroundPlayer: AVAudioPlayer?
    static var buttonPlayer: AVAudioPlayer?
    
    static func playBackgroundMusic(named name: String) {
        guard let url = Bundle.main.url(forResource: name, withExtension: "mp3") else {
            print( "Background music file not found.")
            return
        }
        
        do {
            backgroundPlayer = try AVAudioPlayer(contentsOf: url)
            backgroundPlayer?.numberOfLoops = -1 // infinite loop
            backgroundPlayer?.volume = 0.4
            backgroundPlayer?.play()
        } catch {
            print("Error playing background music: \(error.localizedDescription)")
        }
    }
    
    static func playSound(named name: String) {
        guard let url = Bundle.main.url(forResource: name, withExtension: "mp3") else {
            print( "Sound file not found.")
            return
        }
        
        do {
            buttonPlayer = try AVAudioPlayer(contentsOf: url)
            buttonPlayer?.volume = 1.0
            buttonPlayer?.prepareToPlay()
            buttonPlayer?.play()
        } catch {
            print("Error playing sound: \(error.localizedDescription)")
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
                .font(.system(size: 50, weight: .bold, design: .rounded))
            
            Text("""
Tap the bubbles quickly!
The game lasts 30 seconds.
Do your best and have fun :)
""")
                .font(.system(size: 35, weight: .bold, design: .rounded))
                .multilineTextAlignment(.center)
                .padding()
            
            Button("Go!") {
                SoundPlayer.playSound(named: "go")
                showInstructions = false
            }
                .font(.system(size: 40, weight: .semibold, design: .rounded))
                .padding(.horizontal, 50)
                .padding(.vertical, 20)
                .background(Color.black)
                .foregroundColor(.white)
                .cornerRadius(16)
                .contentShape(Rectangle())
                .padding(.all, 10)
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
                .font(.system(size: 50, weight: .bold, design: .rounded))
            
            Button("Start!") {
                SoundPlayer.playSound(named: "start")
                showGame = true
            }
                .font(.system(size: 40, weight: .semibold, design: .rounded))
                .padding(.horizontal, 50)
                .padding(.vertical, 20)
                .background(Color.black)
                .foregroundColor(.white)
                .cornerRadius(16)
                .contentShape(Rectangle())
                .padding(.all, 10)
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
                .font(.system(size: 45, weight: .bold, design: .rounded))
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
                .font(.system(size: 50, weight: .bold, design: .rounded))
            
            Text("===== Your TapTap Summary =====")
                .font(.system(size: 45, weight: .bold, design: .rounded))
                .padding(.bottom)
            
            HStack {
                Image(systemName: "timer")
                    .font(.system(size: 36, weight: .bold))
                Text("Average Reaction Time: ? seconds")
                    .font(.system(size: 40, weight: .bold, design: .rounded))
            }
            HStack {
                Image(systemName: "bubbles.and.sparkles")
                    .font(.system(size: 36, weight: .bold))
                Text("Bubbles Touched: ?")
                    .font(.system(size: 40, weight: .bold, design: .rounded))
            }
            HStack {
                Image(systemName: "engine.emission.and.exclamationmark")
                    .font(.system(size: 36, weight: .bold))
                Text("Bubbles Missed: ?")
                    .font(.system(size: 40, weight: .bold, design: .rounded))
            }
            HStack {
                Image(systemName: "hand.rays")
                    .font(.system(size: 36, weight: .bold))
                Text("Accuracy: ?%")
                    .font(.system(size: 40, weight: .bold, design: .rounded))
            }
        }
        .padding(40)
    }
}

#Preview(windowStyle: .volumetric) {
    Instruction()
}
