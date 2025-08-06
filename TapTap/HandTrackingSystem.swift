import SwiftUI
import ARKit
import RealityKit
import RealityKitContent

class HandTrackingSystem: System {
    private let arSession = ARKitSession()
    private let handTracking = HandTrackingProvider()
    
    static var latestLeftHand: HandAnchor?
    static var latestRightHand: HandAnchor?
    static var isSessionRunning = false
    static var sessionError: String?
    static var environment: String = ""
    
    required init(scene: RealityKit.Scene) {
        print("🔧 HandTrackingSystem initialized")
        
        #if targetEnvironment(simulator)
        Self.environment = "Simulator"
        Self.sessionError = "Hand tracking not available in simulator"
        print("🖥️ Running in simulator - hand tracking disabled")
        #else
        Self.environment = "Device"
        Task { @MainActor in
            await self.startSession()
        }
        #endif
    }
    
    @MainActor
    private func startSession() async {
        // Double-check if hand tracking is supported
        guard HandTrackingProvider.isSupported else {
            Self.sessionError = "Hand tracking not supported on this device"
            print("❌ Hand tracking not supported")
            return
        }
        
        do {
            print("🚀 Attempting to start hand tracking on real device...")
            try await arSession.run([handTracking])
            Self.isSessionRunning = true
            Self.sessionError = nil
            print("✅ Hand tracking session started successfully")
        } catch {
            Self.sessionError = "Session failed: \(error.localizedDescription)"
            print("❌ Failed to start hand tracking: \(error)")
        }
    }
    
    func update(context: SceneUpdateContext) {
        #if !targetEnvironment(simulator)
        guard Self.isSessionRunning else { return }
        
        let hands = handTracking.handAnchors(at: context.deltaTime)
        
        if let leftHand = hands.leftHand {
            Self.latestLeftHand = leftHand
            print("👋 Left hand detected")
        } else {
            Self.latestLeftHand = nil
        }
        
        if let rightHand = hands.rightHand {
            Self.latestRightHand = rightHand
            print("👋 Right hand detected")
        } else {
            Self.latestRightHand = nil
        }
        #endif
    }
}
