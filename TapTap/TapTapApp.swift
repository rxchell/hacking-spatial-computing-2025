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
        WindowGroup {
            ContentView()
        }
        .windowStyle(.volumetric)
        
        // The immersive space that defines `HeadPositionView`.
        ImmersiveSpace(id: "HandTrackingScene") {
            HandTrackingView()
        }
    }
}
