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
                // Add the initial RealityKit content
                if let scene = try? await Entity(named: "Scene", in: realityKitContentBundle) {
                    content.add(scene)
                }
            } update: { content in
                // Update the RealityKit content when SwiftUI state changes
                if let scene = content.entities.first {
                    let uniformScale: Float = enlarge ? 1.4 : 1.0
                    scene.transform.scale = [uniformScale, uniformScale, uniformScale]
                }
            }
            .gesture(TapGesture().targetedToAnyEntity().onEnded { _ in
                enlarge.toggle()
            })

            VStack {
                Button {
                    enlarge.toggle()
                } label: {
                    Text(enlarge ? "Reduce RealityView Content" : "Enlarge RealityView Content")
                }
                .animation(.none, value: 0)
                .fontWeight(.semibold)
            }
            .padding()
            .glassBackgroundEffect()
        }
    }
}

#Preview(windowStyle: .volumetric) {
    ContentView()
}
