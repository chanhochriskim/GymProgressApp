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
    // NSSortDescriptor = ensures workouts are displayed in descending order.
    @FetchRequest( // fetchrequest is needed for retrieving saved workout records.
        entity: WorkoutRecordEntity.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \WorkoutRecordEntity.date, ascending: false)]
    ) var workoutRecords: FetchedResults<WorkoutRecordEntity>

    
   
    var workoutRecords: [WorkoutRecord]
    @EnvironmentObject var workoutData: WorkoutData // access shared data
    
    var body: some View {
        
        List {
            ForEach(workoutRecords) { record in
                VStack(alignment: .leading, spacing: 5) {
                            Text("Date: \(formattedDate(record.date))")
                                .font(.headline)
                            Text("Split: \(record.split ?? "N/A")")
                            Text("Duration: \(calculateDuration(startTime: record.startTime ?? Date(), endTime: record.endTime ?? Date()))")
                            Text("Rating: \(record.rating ?? "N/A")")
                            Text("Notes: \(record.notes ?? "N/A")")
                        }
                .padding()
            }
        }
        .listStyle(PlainListStyle()) // adjusting list style
        
        VStack {
            Text("Dashboard")
                .font(.largeTitle)
                .padding()
            
            List(workoutRecords, id: \.id) { record in
                VStack(alignment: .leading, spacing: 5) {
                    Text("Date: \(formattedDate(record.date))")
                        .font(.headline)
                    Text("Split: \(record.split)")
                    Text("Duration: \(record.duration)")
                    Text("Rating: \(record.rating)")
                    Text("Notes: \(record.notes)")
                }
                .padding()
            }
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
        let workoutData = WorkoutData()
        
        // Add sample data
        workoutData.workoutRecords = [
            WorkoutRecord(date: Date(), split: "Chest", startTime: Date(), endTime: Date(), rating: "Good", notes: "Solid session"),
            WorkoutRecord(date: Date(), split: "Legs", startTime: Date(), endTime: Date(), rating: "Phenomenal", notes: "Felt strong!")
        ]
        
        return DashboardView(workoutRecords: workoutData.workoutRecords)
            .environmentObject(workoutData) // Inject the environment object
    }
}
