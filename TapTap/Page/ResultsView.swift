//
//  ResultsView.swift
//  TapTap
//
//  Created by Interactive 3D Design on 7/8/25.
//

import SwiftUI

struct ResultsView: View {
    var body: some View {
        VStack(spacing: 32) {
            Text("Great job! 🎉 Thanks for playing TapTap.")
                .font(.system(size: 50, weight: .bold))
            
            Text("=== Your TapTap Summary ===")
                .font(.system(size: 45, weight: .bold))
                .padding(.bottom)
            
            HStack {
                Image(systemName: "timer")
                    .font(.system(size: 36, weight: .bold))
                Text("Average Reaction Time: ? seconds")
                    .font(.system(size: 40, weight: .bold))
            }
            HStack {
                Image(systemName: "bubbles.and.sparkles")
                    .font(.system(size: 36, weight: .bold))
                Text("Bubbles Touched: ?")
                    .font(.system(size: 40, weight: .bold))
            }
            HStack {
                Image(systemName: "engine.emission.and.exclamationmark")
                    .font(.system(size: 36, weight: .bold))
                Text("Bubbles Missed: ?")
                    .font(.system(size: 40, weight: .bold))
            }
            HStack {
                Image(systemName: "hand.rays")
                    .font(.system(size: 36, weight: .bold))
                Text("Accuracy: ?%")
                    .font(.system(size: 40, weight: .bold))
            }
        }
        .padding(40)
    }
}
