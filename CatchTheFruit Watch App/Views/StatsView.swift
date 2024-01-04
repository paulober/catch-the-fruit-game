//
//  StatsView.swift
//  CatchTheFruit Watch App
//
//  Created by Paul on 04.01.24.
//

import SwiftUI
import SwiftData

struct StatsView: View {
    @Environment(\.modelContext) private var modelContext
    @Query var stats: [Score]
    
    func formatDateToMMDDYY(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM.dd.yy"
        return dateFormatter.string(from: date)
    }
    
    var body: some View {
        if stats.count > 0 {
            VStack {
                List {
                    Button {
                        do {
                            try modelContext.delete(model: Score.self)
                        } catch {
                            print("[SwiftData] Error deleting all scores!")
                        }
                    } label: {
                        Label("Delete all", systemImage: "trash.circle")
                    }
                    
                    ForEach(stats) { score in
                        HStack {
                            Text("\(score.score)")
                                .font(.callout)
                                .fontWeight(.semibold)
                            
                            Spacer()
                            
                            Text(formatDateToMMDDYY(date: score.date))
                                .font(.footnote)
                                .fontWeight(.thin)
                        }
                    }
                    .onDelete(perform: { indexSet in
                        for item in indexSet {
                            modelContext.delete(stats[item])
                            modelContext.autosaveEnabled = true
                        }
                    })
                }
                .scenePadding()
            }
        } else {
            Text("There are no statistics to display.")
                .scenePadding()
        }
    }
}

#Preview {
    StatsView()
}
