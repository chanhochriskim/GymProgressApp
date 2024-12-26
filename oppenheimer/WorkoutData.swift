//
//  WorkoutData.swift
//  oppenheimer
//
//  Created by Chris Kim on 12/26/24.
//

import SwiftUI


// connecting dailyworkoutview to dashboardview 
class WorkoutData: ObservableObject {
    // shared records
    @Published var workoutRecords: [WorkoutRecord] = []
}


