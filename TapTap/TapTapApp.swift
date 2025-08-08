//
//  TapTapApp.swift
//  TapTap
//
//  Created by Interactive 3D Design on 6/8/25.
//

import SwiftUI

@main
struct TapTapApp: App {
    @StateObject private var gameData = GameData()
        
    var body: some Scene {
        ImmersiveSpace() {
            ContentView()
        }
        
        WindowGroup(id: "HomeView") {
            HomeView()
        }.windowStyle(.automatic)
        
        WindowGroup(id: "InstructionsView") {
            InstructionsView()
        }.windowStyle(.automatic)
        
        WindowGroup(id: "StartGameView") {
            StartGameView()
        }.windowStyle(.automatic)
        
        ImmersiveSpace(id: "BubblesView") {
            BubblesView().environmentObject(gameData)
        }
        
        WindowGroup(id: "ResultsView") {
            ResultsView().environmentObject(gameData)
        }.windowStyle(.automatic)
    }
}
