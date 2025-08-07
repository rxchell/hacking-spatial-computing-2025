//
//  TapTapApp.swift
//  TapTap
//
//  Created by Interactive 3D Design on 6/8/25.
//

import SwiftUI

@main
struct TapTapApp: App {
    var body: some Scene {
        ImmersiveSpace() {
            ContentView()
        }
        
        WindowGroup(id: "InstructionsView") {
            InstructionsView()
        }.windowStyle(.volumetric)
        
        WindowGroup(id: "StartGameView") {
            StartGameView()
        }.windowStyle(.volumetric)
        
        ImmersiveSpace(id: "BubblesView") {
            BubblesView()
        }
        
        WindowGroup(id: "ResultsView") {
            ResultsView()
        }.windowStyle(.volumetric)
    }
}
