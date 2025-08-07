//
//  SoundPlayer.swift
//  TapTap
//
//  Created by Interactive 3D Design on 7/8/25.
//

import AVFoundation

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
        print("✅ Found sound file: \(url)")
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
