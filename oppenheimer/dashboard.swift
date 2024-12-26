//
//  dashboard.swift
//  oppenheimer
//
//  Created by Chris Kim on 11/24/24.
// preview: option command enter

import SwiftUI

struct DashboardView: View {
    var workoutRecords: [WorkoutRecord]
    @EnvironmentObject var workoutData: WorkoutData // access shared data
    
    var body: some View {
        VStack {
            Text("Dashboard")
                .font(.largeTitle)
                .padding()
            
            List(workoutRecords, id: \.id) { record in
                VStack(alignment: .leading, spacing: 5) {
                    Text("Date: \(formattedDate(record.date))")
                        .font(.headline)
                    Text("Split: \(record.split)")
                    Text("Duration: \(formattedTime(record.startTime)) - \(formattedTime(record.endTime))")
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
