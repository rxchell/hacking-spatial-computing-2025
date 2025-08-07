//
//  BubblesView.swift
//  TapTap
//
//  Created by Interactive 3D Design on 7/8/25.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct BubblesView: View {

    @State var enlarge = false
    @State var tapped = false
    @State var tappedName = ""
    @State var orbDict: [String: Entity] = [:]
    @State var timeList: [Float] = []

    var body: some View {
        VStack{
            RealityView { content in
                let anchor = AnchorEntity(world: .zero)
                content.add(anchor)
                
                Task { @MainActor in
                    do {
                        let orbScene = try await Entity(named: "OrbScene", in: realityKitContentBundle)
                        
                        if let orb = orbScene.findEntity(named: "Sphere") {
                            while true {
                                let orbClone = orb.clone(recursive: true)
                                let id = UUID().uuidString
                                orbClone.name = "Orb-\(id)"
                                orbDict[id] = orbClone
                                
                                let x = Float.random(in: 0...1)
                                let y = Float.random(in: 1...2)
                                
                                orbClone.position = SIMD3(x, y, -1)
                                
                                orbClone.components.set(CollisionComponent(shapes: [.generateSphere(radius: 1)]))
                                orbClone.components.set(InputTargetComponent())
                                
                                
                                Task.detached {
                                    try? await Task.sleep(for: .seconds(3))
                                    
                                    await MainActor.run {
                                                                orbClone.removeFromParent()
                                                            }
                                }
                                
                                Task.detached {
                                    while true {
                                        if (tapped == true) {
                                            for (_, orb) in orbDict {
                                                if (orb.name == tappedName) {
                                                    await orb.removeFromParent()
                                                    print("Execute")
                                                    tapped = false
                                                    tappedName = ""
                                                }
                                            }
                                        }
                                    }
                                }
                                
                                anchor.addChild(orbClone)
                                try? await Task.sleep(for: .seconds(3))
                            }
                        } else {
                            print("Sphere entity not found inside OrbScene")
                        }
                    } catch {
                        print("Failed to load OrbScene: \(error)")
                    }
                }
            }.gesture(TapGesture().targetedToAnyEntity().onEnded { value in
                    print("Entity tapped! \(value)")
                tappedName = value.entity.name
                    tapped = true
            })
        }
    }
}

#Preview(windowStyle: .volumetric) {
    BubblesView()
}
