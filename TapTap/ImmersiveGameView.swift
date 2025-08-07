//
//  ImmersiveGameView.swift
//  TapTap
//
//  Created by Rachel  on 7/8/25.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ImmersiveGameView: View {
    @State private var anchor = AnchorEntity(world: .zero)
    @State private var subscriptions: [EventSubscription] = []

    var body: some View {
        RealityView { content in
            content.add(anchor)
            spawnBubble()
            
            // Subscribe to tap events on the content
            let subscription = content.subscribe(to: SceneEvents.Update.self) { _ in
                // Handle any scene updates if needed
            }
            subscriptions.append(subscription)
        }
        .gesture(
            SpatialTapGesture()
                .targetedToAnyEntity()
                .onEnded { value in
                    handleTap(on: value.entity)
                }
        )
    }

    func spawnBubble() {
        Task {
            do {
                let scene = try await Entity(named: "OrbScene", in: realityKitContentBundle)
                guard let bubble = scene.findEntity(named: "Sphere") else {
                    print("'Sphere' entity not found in OrbScene")
                    return
                }

                // Enable tap interaction
                bubble.generateCollisionShapes(recursive: true)
                bubble.components.set(InputTargetComponent())
                bubble.components.set(CollisionComponent(shapes: [.generateSphere(radius: 0.1)]))

                // Random position in front of the user
                bubble.position = SIMD3(
                    Float.random(in: -0.5...0.5),
                    Float.random(in: 0.8...1.2),
                    Float.random(in: -1.2 ... -0.8)
                )

                // Add a name component to identify the bubble
                bubble.name = "TappableBubble"

                anchor.addChild(bubble)

            } catch {
                print("Failed to load OrbScene: \(error)")
            }
        }
    }
    
    func handleTap(on entity: Entity) {
        // Check if the tapped entity is a bubble
        if entity.name == "TappableBubble" {
            entity.removeFromParent()
            spawnBubble()
        }
    }
}
