//
//  SharedContent.swift
//  TapTap
//
//  Created by Interactive 3D Design on 7/8/25.
//

import SwiftUI

class GameData: ObservableObject {
    @Published var timeList: [Float] = []
    @Published var totalSpawn = 0
    @Published var leftCount = 0
    @Published var left = 0
    @Published var middleCount = 0
    @Published var middle = 0
    @Published var rightCount = 0
    @Published var right = 0
}
