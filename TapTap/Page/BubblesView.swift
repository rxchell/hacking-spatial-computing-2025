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

    @EnvironmentObject var gameData: GameData
    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace
    @State var enlarge = false
    @State var tapped = false
    @State var tappedName = ""
    @State var orbDict: [String: OrbData] = [:]
    @State var timeInterval = 30

    var body: some View {
        VStack{
            RealityView { content in
                let anchor = AnchorEntity(world: .zero)
                content.add(anchor)
                
                Task { @MainActor in
                    while timeInterval > 0 {
                    try? await Task.sleep(for: .seconds(1))
                    timeInterval -= 1
                    print("timeInterval: \(timeInterval)")
                    }
                }
                
                Task { @MainActor in
                    do {
                        let orbScene = try await Entity(named: "OrbScene", in: realityKitContentBundle)
                        
                        if let orb = orbScene.findEntity(named: "Sphere") {
                            while timeInterval > 0 {
                                let orbClone = orb.clone(recursive: true)
                                let id = UUID().uuidString
                                orbClone.name = "Orb-\(id)"
                                let spawnTime = Date()
                                orbDict[id] = OrbData(entity: orbClone, spawnTime: spawnTime)
                                
                                let x = Float.random(in: -0.5...0.5)
                                let y = Float.random(in: 1.2...2.2)
                                
                                orbClone.transform = Transform(
                                    scale: .one,
                                    rotation: simd_quatf(angle: 0, axis: [0, 1, 0]),
                                    translation: SIMD3(x, y, -1)
                                )
                                anchor.addChild(orbClone)

                                
                                orbClone.components.set(CollisionComponent(shapes: [.generateSphere(radius: 0.1)]))
                                orbClone.components.set(InputTargetComponent())
                                
                                
                                Task.detached {
                                    try? await Task.sleep(for: .seconds(2))
                                    
                                    await MainActor.run {
                                                                orbClone.removeFromParent()
                                                            }
                                }
                                
                                Task.detached {
                                    while true {
                                        if (tapped == true) {
                                            for (_, orb) in orbDict {
                                                if (orb.entity.name == tappedName) {
                                                    await orb.entity.removeFromParent()
                                                    print("Execute")
                                                    tapped = false
                                                    tappedName = ""
                                                }
                                            }
                                        }
                                    }
                                }

                                
                                anchor.addChild(orbClone)
                                let targetPosition = SIMD3<Float>(x, y, 1)
                                orbClone.move(
                                    to: Transform(
                                        scale: .one,
                                        rotation: simd_quatf(angle: 0, axis: [0, 1, 0]),
                                        translation: targetPosition
                                    ),
                                    relativeTo: anchor, // ✅ Correct parent reference
                                    duration: 4.0,
                                    timingFunction: .easeIn
                                )
                                try? await Task.sleep(for: .seconds(2))
                            }
                        } else {
                            print("Sphere entity not found inside OrbScene")
                        }
                        
                        if (timeInterval <= 0) {
                            await dismissImmersiveSpace()
                            openWindow(id: "ResultsView")
                        }
                    } catch {
                        print("Failed to load OrbScene: \(error)")
                    }
                }
            }.overlay(
                Text("Time Left: \(timeInterval) seconds")
                    .font(.title)
                    .padding()
                    .background(Color.black.opacity(0.5))
                    .cornerRadius(10)
                    .foregroundColor(.white)
                    .padding(),
                alignment: .top
                    ).gesture(TapGesture().targetedToAnyEntity().onEnded { value in
                    print("Entity tapped! \(value)")
                tappedName = value.entity.name
                    tapped = true
                
                if let orbData = orbDict.first(where: { $0.value.entity == value.entity })?.value {
                                let reactionTime = Float(Date().timeIntervalSince(orbData.spawnTime))
                    gameData.timeList.append(reactionTime)
                                print("Reaction Time: \(reactionTime) seconds")
                            } else {
                                print("No orb data found for tapped entity.")
                            }
            })
        }
    }
}

struct OrbData {
    var entity: Entity
    var spawnTime: Date
}


#Preview(windowStyle: .volumetric) {
    BubblesView()
}
