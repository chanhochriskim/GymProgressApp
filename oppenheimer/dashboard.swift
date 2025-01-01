//
//  dashboard.swift
//  oppenheimer
//
//  Created by Chris Kim on 11/24/24.
// preview: option command enter

import SwiftUI
import CoreData

struct DashboardView: View {
    // WorkoutRecordEntity = coredata entity that stores workout logs.
    // NSSortDescriptor = ensures workouts are displayed in descending order
   
    @FetchRequest( // fetchrequest is needed for retrieving saved workout records.
        entity: WorkoutRecordEntity.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \WorkoutRecordEntity.date, ascending: false)]
    ) var workoutRecords: FetchedResults<WorkoutRecordEntity>


    @EnvironmentObject var workoutData: WorkoutData // access shared data
    
    var body: some View {
    
        VStack {
            Text("Dashboard")
                .font(.largeTitle)
                .padding()
    
            List {
                ForEach(workoutRecords) { record in
                    VStack(alignment: .leading, spacing: 5) {
                        if let date = record.date {
                            Text("Date: \(formattedDate(date))")
                                .font(.headline)
                        } else {
                            Text("Date: N/A")
                                .font(.headline)
                        }
                                Text("Split: \(record.split)")
                        if let startTime = record.startTime, let endTime = record.endTime {
                                        Text("Duration: \(calculateDuration(startTime: startTime, endTime: endTime))")
                                    } else {
                                        Text("Duration: N/A")
                                    }
                                Text("Rating: \(record.rating)")
                                Text("Notes: \(record.notes)")
                            }
                    .padding()
                }
            }
            .listStyle(PlainListStyle()) // adjusting list style
        }
    }
    
    // date formatting helper
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
    
    // time formatting helper
    private func formattedTime(_ time: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: time)
    }
    
    // duration calculator (helper)
    private func calculateDuration(startTime: Date, endTime: Date) -> String {
        let interval = endTime.timeIntervalSince(startTime)
        let hours = Int(interval) / 3600
        let minutes = (Int(interval) % 3600) / 60
        return "\(hours) hr \(minutes)min"
    }
    
    
    
}



struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
            .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}
