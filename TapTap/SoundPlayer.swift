import AVFoundation

class SoundPlayer {
    private static var sessionConfigured = false
    private static var persistentPlayers: [String: AVAudioPlayer] = [:] // keeps references alive
    
    /// Configure audio session once for the whole app
    private static func configureAudioSession() {
        guard !sessionConfigured else { return }
        do {
            try AVAudioSession.sharedInstance().setCategory(.ambient, mode: .default, options: [.mixWithOthers])
            try AVAudioSession.sharedInstance().setActive(true)
            print("🎧 Audio session configured")
            sessionConfigured = true
        } catch {
            print("❌ Failed to configure audio session: \(error.localizedDescription)")
        }
    }
    
    /// Play background music (loops indefinitely)
    static func playBackgroundMusic(named name: String, ext: String = "mp3") {
        configureAudioSession()
        guard let url = Bundle.main.url(forResource: name, withExtension: ext) else {
            print("❌ Background music file not found: \(name).\(ext)")
            return
        }
        do {
            let player = try AVAudioPlayer(contentsOf: url)
            player.numberOfLoops = -1
            player.volume = 0.4
            player.play()
            persistentPlayers["background"] = player
        } catch {
            print("❌ Error playing background music: \(error.localizedDescription)")
        }
    }
    
    /// Play a short sound effect
    static func playSound(named name: String, ext: String = "mp3") {
        configureAudioSession()
        guard let url = Bundle.main.url(forResource: name, withExtension: ext) else {
            print("❌ Sound file not found: \(name).\(ext)")
            return
        }
        do {
            let player = try AVAudioPlayer(contentsOf: url)
            player.volume = 1.0
            player.prepareToPlay()
            player.play()
            persistentPlayers[name] = player
            
            // Clean up after sound finishes (so we don't hold memory forever)
            DispatchQueue.main.asyncAfter(deadline: .now() + player.duration) {
                persistentPlayers.removeValue(forKey: name)
            }
        } catch {
            print("❌ Error playing sound: \(error.localizedDescription)")
        }
    }
}
