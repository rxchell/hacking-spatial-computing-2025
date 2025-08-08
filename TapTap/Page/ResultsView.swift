//
//  ResultsView.swift
//  TapTap
//
//  Created by Interactive 3D Design on 7/8/25.
//

import SwiftUI

struct ResultsView: View {
    @EnvironmentObject var gameData: GameData
    
    var body: some View {
        VStack(spacing: 50) {
            VStack(alignment: .center, spacing: 40) {
                VStack(spacing: 10) {
                    Text("Great job 🎉")
                        .font(.system(size: 70, weight: .bold, design: .rounded))
                        .multilineTextAlignment(.center)

                    Text("Thank you for playing TapTap")
                        .font(.system(size: 70, weight: .bold, design: .rounded))
                        .multilineTextAlignment(.center)
                }
                .padding(.top)
            }
            
            VStack(alignment: .leading, spacing: 32) {
                HStack(spacing: 30) {
                    Image(systemName: "timer")
                        .font(.system(size: 60, weight: .bold))
                        .frame(width: 60)
                    Text("Average Reaction Time:").resultLabelStyle()
                    Text("\(averageTimer(timers: gameData.timeList), specifier: "%.2f") seconds").resultValueStyle()
                }
                HStack(spacing: 30) {
                    Image(systemName: "hand.rays")
                        .font(.system(size: 60, weight: .bold))
                        .frame(width: 60)
                    Text("Balls Touched:").resultLabelStyle()
                    Text("\(gameData.timeList.count)").resultValueStyle()
                }
                HStack(spacing: 30) {
                    Image(systemName: "engine.emission.and.exclamationmark")
                        .font(.system(size: 60, weight: .bold))
                        .frame(width: 60)
                    Text("Balls Missed:").resultLabelStyle()
                    Text("\(gameData.totalSpawn-gameData.timeList.count)").resultValueStyle()
                }
                HStack(spacing: 30) {
                    Image(systemName: "checkmark.circle")
                        .font(.system(size: 60, weight: .bold))
                        .frame(width: 60)
                    Text("Accuracy:").resultLabelStyle()
                    let accuracy = (Float(gameData.timeList.count) / Float(gameData.totalSpawn)) * 100
                        Text("\(accuracy, specifier: "%.2f") %").resultValueStyle()
                }
            }
            .padding(150)
            .glassBackgroundEffect()
            .onAppear {
                SoundPlayer.playSound(named: "great")
            }
        }
    }
}


func averageTimer(timers: [Float]) -> Float {
    var total: Float = 0
    for t in timers {
        total += t
    }
    
    return timers.isEmpty ? 0 : total / Float(timers.count)
}
