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

    @State var enlarge = false
    
    /// The environment value to get the `OpenImmersiveSpaceAction` instance.
    @Environment(\.openImmersiveSpace) var openImmersiveSpace

    var body: some View {
        Text("Hand Tracking Enabled")
            .onAppear {
                Task {
                    await openImmersiveSpace(id: "HandTrackingScene")
                }
            }
        VStack {
            RealityView { content in
                let anchor = AnchorEntity(world: .zero)
                content.add(anchor)
                
                Task { @MainActor in
                    do {
                        let orbScene = try await Entity(named: "OrbScene", in: realityKitContentBundle)
                        
                        if let orb = orbScene.findEntity(named: "Sphere") {
                            while true {
                                let orbClone = orb.clone(recursive: true)
                                
                                let x = Float.random(in: 0...1)
                                let y = Float.random(in: 1...2)
                                
                                
                                orbClone.position = SIMD3(x, y, -1)
                                
                                anchor.addChild(orbClone)
                                try? await Task.sleep(for: .seconds(2))
                            }
                        } else {
                            print("Sphere entity not found inside OrbScene")
                        }
                    } catch {
                        print("Failed to load OrbScene: \(error)")
                    }
                }
            }
        }
    }
}

#Preview(windowStyle: .volumetric) {
    ContentView()
}
