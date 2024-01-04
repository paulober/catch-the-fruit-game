//
//  GameView.swift
//  CatchTheFruit Watch App
//
//  Created by Paul on 02.01.24.
//

import SwiftUI
import SwiftData

let gridSizeX = 4
let gridSizeY = 4

struct GameView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Binding var gamePaused: Bool
    @State private var isAppleVisible = false
    @State private var countdownTimer = 0.0
    @State private var appleCoord = (0,0)
    @State private var appleCounter: UInt16 = 0
    
    var body: some View {
        GeometryReader { geometry in
            let circleWidth = (geometry.size.width - CGFloat(4 + 1) * 5) / CGFloat(4)
            let circleHeight = (geometry.size.height - CGFloat(4 + 1) * 1) / CGFloat(4)
            ZStack {
                VStack(spacing: 7) {
                    ForEach(0..<4) { row in
                        HStack(spacing: 6) {
                            ForEach(0..<4) { column in
                                Circle()
                                    .fill(Color.white.opacity(0.6))
                                    .frame(width: circleWidth, height: circleHeight)
                                    .overlay(
                                        Circle()
                                            .stroke(Color.brown, lineWidth: 1)
                                    )
                                    .onTapGesture {
                                        resetApple()
                                        
                                        // end game
                                        gamePaused = true
                                        // save score if > 0
                                        if self.appleCounter > 0 {
                                            let newScore = Score(id: UUID(), score: self.appleCounter, date: Date())
                                            self.modelContext.insert(newScore)
                                            do {
                                                try self.modelContext.save()
                                            } catch {
                                                print("[SwiftData] Failed to save statistics.")
                                            }
                                        }
                                    }
                            }
                        }
                    }
                }
                .padding(5)
                .padding(.top, -20)
                .background(
                    Image("GameWoodenTexture")
                        .resizable()
                        .ignoresSafeArea()
                        .scaledToFill()
                )
                
                if isAppleVisible {
                    let appleWidth = circleWidth - 4 // CGFloat(35)
                    let appleHeight = circleHeight - 4 //CGFloat(35)
                    
                    AppleView()
                        .position(
                            // CGFloat(appleCoord.0)
                            x: ((circleWidth+5) * CGFloat(appleCoord.0)) - (geometry.size.width/3) + 10,
                            y: ((circleHeight+7) * CGFloat(appleCoord.1)) - (geometry.size.height/3) - 8
                        )
                        .frame(
                            width: appleWidth,
                            height: appleHeight
                        )
                        .onAppear {
                            //startCountdownTimer()
                            startDisappearTimer()
                        }
                        .onTapGesture {
                            // Add your logic here when an apple is tapped
                            resetApple()
                            startCountdownTimer()
                            
                            appleCounter += 1
                        }
                }
                
                Text("Apples: \(appleCounter)")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .position(x: 60, y: -33)
            }
            .onAppear {
                startCountdownTimer()
            }
        }
    }

    private func startCountdownTimer() {
        countdownTimer = Double.random(in: 0.5...1.0)
        appleCoord = (Int.random(in: 0..<gridSizeX), Int.random(in: 0..<gridSizeY))
        
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            if countdownTimer > 0 {
                countdownTimer -= 0.1
            } else {
                timer.invalidate()
                isAppleVisible = true
            }
        }
    }
    
    private func startDisappearTimer() {
        Timer.scheduledTimer(withTimeInterval: Double.random(in: 0.7...1.1), repeats: false) { timer in
            resetApple()
            timer.invalidate()
            startCountdownTimer()
        }
    }

    private func resetApple() {
        isAppleVisible = false
    }
}

struct AppleView: View {
    var body: some View {
        Image(["apple-red-1", "apple-red-2", "apple-green-1", "apple-green-2"].randomElement() ?? "apple-green-2")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .transition(.move(edge: .leading))
    }
}

#Preview {
    GameView(gamePaused: .constant(false))
}
