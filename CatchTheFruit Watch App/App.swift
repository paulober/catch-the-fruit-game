//
//  App.swift
//  CatchTheFruit Watch App
//
//  Created by Paul on 02.01.24.
//

import SwiftUI
import SwiftData

@main
struct CatchTheFruitApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [
                    Score.self
                ])
        }
    }
}
