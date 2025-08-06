import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {
    @State var debugMessage: String = "Initializing..."
    @State var showDebugInfo: Bool = true
    
    var body: some View {
        ZStack {
            RealityView { content in
                // 1. Create anchor at a more visible position
                let anchor = AnchorEntity(.head) // Changed to head anchor for better visibility
                anchor.position = [0, 0, -1] // 1 meter in front
                content.add(anchor)
                
                // 2. First test - simple generated sphere
                let testSphere = createTestSphere(name: "RedTestSphere", color: .red)
                anchor.addChild(testSphere)
                debugMessage = "✓ Added red test sphere at \(testSphere.position)"
                
                // 3. Second test - simple box
                let testBox = createTestBox()
                testBox.position = [0, 0.3, 0] // Above the sphere
                anchor.addChild(testBox)
                debugMessage += "\n✓ Added blue test box"
                
                // 4. Attempt to load custom content
                Task { @MainActor in
                    do {
                        debugMessage += "\n⌛ Loading OrbScene..."
                        
                        guard let scene = try? await Entity(named: "OrbScene", in: realityKitContentBundle) else {
                            debugMessage += "\n❌ Failed to load OrbScene"
                            return
                        }
                        
                        debugMessage += "\n✓ Loaded OrbScene with \(scene.children.count) children"
                        
                        // Print complete hierarchy
                        printEntityTree(scene, prefix: "SceneRoot")
                        
                        // Try three different approaches:
                        // Approach 1: Add entire scene
                        let sceneClone = scene.clone(recursive: true)
                        sceneClone.position = [-0.3, 0, 0] // Left side
                        anchor.addChild(sceneClone)
                        debugMessage += "\n✓ Added full scene clone"
                        
                        // Approach 2: Find specific sphere
                        if let sphere = scene.findEntity(named: "Sphere") {
                            let sphereClone = sphere.clone(recursive: true)
                            sphereClone.position = [0.3, 0, 0] // Right side
                            sphereClone.scale = [1, 1, 1] // Ensure not too small
                            anchor.addChild(sphereClone)
                            debugMessage += "\n✓ Added named sphere clone"
                        } else {
                            debugMessage += "\n⚠️ 'Sphere' entity not found"
                        }
                        
                        // Approach 3: Add all children
                        for child in scene.children {
                            let childClone = child.clone(recursive: true)
                            childClone.position = [0, -0.3, 0] // Bottom
                            anchor.addChild(childClone)
                        }
                        debugMessage += "\n✓ Cloned all \(scene.children.count) children"
                        
                    } catch {
                        debugMessage += "\n❌ Error: \(error.localizedDescription)"
                    }
                }
            }
            
            // Debug panel
            if showDebugInfo {
                VStack {
                    Text(debugMessage)
                        .font(.system(size: 14, design: .monospaced))
                        .padding()
                        .background(Color.black.opacity(0.7))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    
                    Button("Hide Debug") { showDebugInfo = false }
                        .padding()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            } else {
                Button("Show Debug") { showDebugInfo = true }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            }
        }
    }
    
    // Helper functions
    private func createTestSphere(name: String, color: UIColor) -> ModelEntity {
        let mesh = MeshResource.generateSphere(radius: 0.1)
        let material = SimpleMaterial(color: color, roughness: 0.5, isMetallic: true)
        let entity = ModelEntity(mesh: mesh, materials: [material])
        entity.name = name
        return entity
    }
    
    private func createTestBox() -> ModelEntity {
        let mesh = MeshResource.generateBox(size: 0.1)
        let material = SimpleMaterial(color: .blue, roughness: 0.2, isMetallic: false)
        let entity = ModelEntity(mesh: mesh, materials: [material])
        entity.name = "TestBox"
        return entity
    }
    
    private func printEntityTree(_ entity: Entity, prefix: String = "") {
        print("\(prefix)-> \(entity.name) (position: \(entity.position), scale: \(entity.scale))")
        for child in entity.children {
            printEntityTree(child, prefix: prefix + "  ")
        }
    }
}

#Preview(windowStyle: .volumetric) {
    ContentView()
}
