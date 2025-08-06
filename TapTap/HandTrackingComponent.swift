//
//  HandTrackingComponent.swift
//  TapTap
//
//  Created by Rachel  on 6/8/25.
//

import RealityKit
import ARKit

struct HandTrackingComponent: Component {
    let chirality: AnchoringComponent.Target.Chirality
    
    init(chirality: AnchoringComponent.Target.Chirality) {
        self.chirality = chirality
        
        // Only register system if we're on a real device
        #if targetEnvironment(simulator)
        print("Hand tracking disabled in simulator")
        #else
        if HandTrackingProvider.isSupported {
            HandTrackingSystem.registerSystem()
        } else {
            print("Hand tracking not supported on this device")
        }
        #endif
    }
}
