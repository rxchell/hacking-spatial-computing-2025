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

    var body: some View {
        RealityView { content in
            let anchor = AnchorEntity(world: .zero)
            content.add(anchor)
            
            Task {
                do {
                    let orbScene = try await Entity(named: "OrbScene", in: realityKitContentBundle)
                    
                    if let orb = orbScene.findEntity(named: "Sphere") {
                        let orbClone = orb.clone(recursive: true)
                        
                        let x = Float.random(in: -0.5...0.5)
                        let y = Float.random(in: -0.5...0.5)
                        let z = Float.random(in: -0.5...0.5)

                        
                        orbClone.position = SIMD3(x, y, z)
                        orbClone.scale = SIMD3(repeating: 0.2)
                        
                        anchor.addChild(orbClone)
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

#Preview(windowStyle: .volumetric) {
    ContentView()
}
