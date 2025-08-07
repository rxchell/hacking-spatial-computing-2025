//
//  ContentView.swift
//  TapTap
//
//  Created by Interactive 3D Design on 6/8/25.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {
    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace

    var body: some View {
        Text("Launching...").task {
            await dismissImmersiveSpace()
            openWindow(id: "InstructionsView")
        }
    }
}

#Preview(windowStyle: .volumetric) {
    ContentView()
}
