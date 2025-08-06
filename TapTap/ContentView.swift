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
    var body: some View {
        RealityView { content in
            // Create an entity with hand tracking component
            let leftHandEntity = Entity()
            leftHandEntity.components[HandTrackingComponent.self] = HandTrackingComponent(chirality: .left)
            content.add(leftHandEntity)
            
            let rightHandEntity = Entity()
            rightHandEntity.components[HandTrackingComponent.self] = HandTrackingComponent(chirality: .right)
            content.add(rightHandEntity)
            
            // Add some reference objects to see in space
            let referenceBox = Entity()
            let boxMesh = MeshResource.generateBox(size: 0.1)
            let boxMaterial = SimpleMaterial(color: .green, isMetallic: false)
            referenceBox.components[ModelComponent.self] = ModelComponent(mesh: boxMesh, materials: [boxMaterial])
            referenceBox.position = [0, 0, -0.5] // 50cm in front
            content.add(referenceBox)
        }
    }
}

#Preview(windowStyle: .volumetric) {
    ContentView()
}
