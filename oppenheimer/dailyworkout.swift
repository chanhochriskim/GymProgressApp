//
//  dailyworkout.swift
//  oppenheimer
//
//  Created by Chris Kim on 11/24/24.
//

import SwiftUI

struct WorkoutRecord: Identifiable {
    let id = UUID()
    let date: Date
    let split: String
    let startTime: Date
    let endTime: Date
    let rating: String
    let notes: String
}

struct DailyWorkoutView: View {
    @EnvironmentObject var workoutData: WorkoutData // access shared data
    
    @State private var selectedDate = Date() // storing the selectedDate
    @State private var showDatePicker = false // visibility of the calender
    @State private var selectedWorkout: String = "Select Workout"
    
    // duration: start / end times.
    @State private var startTime = Date()
    @State private var endTime = Date()
    
    @State private var selectedRating: String = "Rating Option" // ratings option
    @State private var notes: String = "" // notes input
    
    // List of workout Records
    @State private var workoutRecords: [WorkoutRecord] = []
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Daily Workout Log")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 10)
                
            VStack(spacing: 10) {
                // Date Picker Button
                HStack {
                    Text("Select Date:")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Button(action: {
                        showDatePicker.toggle()
                    }) {
                        // displaying selected date
                        Text("\(formattedDate(selectedDate))")
                            .font(.headline)
                            .padding()
                            .background(Color.white)
                            .foregroundColor(.black)
                    }
                }
                
                
                
                // conditoinal date picker
                if showDatePicker {
                    DatePicker (
                        "Choose Date", selection: $selectedDate, displayedComponents: .date // only showing the calender, not time.
                        
                    )
                    .datePickerStyle(GraphicalDatePickerStyle()) // graphical calender style
                    .padding()
                }
            }
            
            VStack(spacing: 10) {
            // Split Button
                HStack {
                    Text("Split: ")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    // Workout Option Menu
                    Menu {
                        Button(action: {
                            selectedWorkout = "Chest"
                        }) {
                            Text("Chest")
                        }
                        Button(action: {
                            selectedWorkout = "Back"
                        }) {
                            Text("Back")
                        }
                        Button(action: {
                            selectedWorkout = "Arms/Shoulders"
                        }) {
                            Text("Arms/Shoulders")
                        }
                        Button(action: {
                            selectedWorkout = "Legs"
                        }) {
                            Text("Legs")
                        }
                        Button(action: {
                            selectedWorkout = "Others"
                        }) {
                            Text("Others")
                        }
                    } label: {
                        HStack {
                            Text(selectedWorkout)
                                .foregroundColor(.black)
                                
                        }
                        .padding()
                    }
                }
            }
            
            VStack(spacing: 10) {
            // Duration
                HStack {
                    Text("Duration: ")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    VStack {
                        Text("Start")
                            .font(.subheadline)
                        DatePicker (
                            "",
                        selection: $startTime,
                            displayedComponents: .hourAndMinute
                        )
                        .labelsHidden()
                    }
                    Spacer()
                    
                    VStack {
                        Text("End")
                            .font(.subheadline)
                        DatePicker (
                            "",
                            selection: $endTime,
                            displayedComponents: .hourAndMinute
                        )
                        .labelsHidden()
                    }
                }
                .padding()
            }
            
            VStack(spacing: 10) {
            // Rating Options
                HStack {
                    Text("Rating: ")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    // Workout Option Menu
                    Menu {
                        Button(action: {
                            selectedRating = "Phenomenal"
                        }) {
                            Text("Phenomenal")
                        }
                        Button(action: {
                            selectedRating = "Good"
                        }) {
                            Text("Good")
                        }
                        Button(action: {
                            selectedRating = "Ok"
                        }) {
                            Text("Ok")
                        }
                        Button(action: {
                            selectedRating = "Poor"
                        }) {
                            Text("Poor")
                        }
                        
                    } label: {
                        HStack {
                            Text(selectedRating)
                                .foregroundColor(.black)
                                
                        }
                        .padding()
                    }
                }
            }
            
            // notes section
            VStack (alignment: .leading, spacing: 10) {
                Text("Notes: ")
                    .font(.title2)
                    .fontWeight(.bold)
                
                TextEditor(text: $notes)
                    .frame(height: 100)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray, lineWidth: 1)
                    )
            }
            
            // Submission Button!
            Button(action: {
                saveWorkout()
            }) {
                Text("Submit Workout")
                    .font(.title2)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.yellow)
                    .foregroundColor(.black)
                    .cornerRadius(10)
            }
            
            Spacer() // contents to be on the top
        }
        .padding()
    }
    
    // saving workout records
    private func saveWorkout() {
        let newRecord = WorkoutRecord(
            date: selectedDate,
            split: selectedWorkout,
            startTime: startTime,
            endTime: endTime,
            rating: selectedRating,
            notes: notes
        )
        workoutData.workoutRecords.append(newRecord) // save to shared data
        print("Workout Saved: \(newRecord)")
    }
    
    
    // helper function to format the date
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}


#Preview {
    DailyWorkoutView()
}
