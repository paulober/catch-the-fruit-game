//
//  NewGameSheet.swift
//  CatchTheFruit Watch App
//
//  Created by Paul on 02.01.24.
//

import SwiftUI

struct NewGameSheet: View {
    @Binding var gamePaused: Bool
    @Binding var showStats: Bool
    
    var body: some View {
        VStack {
            Text("Catch The Fruit")
                .font(.title3)
                .fontDesign(.serif)
                .fontWeight(.heavy)
            
            Spacer()
            
            Button {
                startNewGame()
            } label: {
                Label("New Game", systemImage: "play")
            }
            
            Button {
                openStats()
            } label: {
                Label("Stats", systemImage: "chart.pie")
            }
        }
    }
    
    func startNewGame() {
        withAnimation {
            gamePaused = false
        }
    }
    
    func openStats() {
        withAnimation {
            gamePaused = true
            showStats = true
        }
    }
}

#Preview {
    NewGameSheet(gamePaused: .constant(true), showStats: .constant(false))
}
