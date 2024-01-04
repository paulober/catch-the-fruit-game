//
//  ContentView.swift
//  CatchTheFruit Watch App
//
//  Created by Paul on 02.01.24.
//

import SwiftUI

struct ContentView: View {
    @State private var gamePaused: Bool = true
    @State private var showStats: Bool = false
    
    var body: some View {
        if gamePaused {
            NewGameSheet(gamePaused: $gamePaused, showStats: $showStats)
                .sheet(isPresented: $showStats) {
                    StatsView()
                }
        } else {
            GameView(gamePaused: $gamePaused)
        }
    }
}

#Preview {
    ContentView()
}
