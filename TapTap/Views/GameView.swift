//
//  GameView.swift
//  TapTap
//
//  Created by Rachel  on 7/8/25.
//

import SwiftUI

import SwiftUI

struct GameView: View {
    @Binding var showGame: Bool
    @Binding var showResults: Bool
    
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace

    let gameDuration: TimeInterval = 30

    var body: some View {
        Text("Loading game...")
            .task {
                await openImmersiveSpace(id: "ImmersiveGame")
            }
    }

    func startGameTimer() {
        Timer.scheduledTimer(withTimeInterval: gameDuration, repeats: false) { _ in
            Task {
                await dismissImmersiveSpace()
                await MainActor.run {
                    showGame = false
                    showResults = true
                }
            }
        }
    }
}
