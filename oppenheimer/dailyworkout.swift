//
//  dailyworkout.swift
//  oppenheimer
//
//  Created by Chris Kim on 11/24/24.
//

import SwiftUI
import CoreData

struct WorkoutRecord: Identifiable {
    let id = UUID()
    let date: Date
    let split: String
    let startTime: Date
    let endTime: Date
    let rating: String
    let notes: String
    
    var duration: String {
        let interval = endTime.timeIntervalSince(startTime)
        let hours = Int(interval) / 3600 
        let minutes = (Int(interval) % 3600) / 60
        return "\(hours)hr \(minutes)min"
    }
}

struct DailyWorkoutView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @EnvironmentObject var workoutData: WorkoutData // access shared data
    
    @State private var selectedDate = Date() // storing the selectedDate
    @State private var showDatePicker = false // visibility of the calender
    @State private var selectedWorkout: String = "Select Workout"
    
    // duration: start / end times.
    @State private var startTime = Date()
    @State private var endTime = Date()
    
    @State private var selectedRating: String = "Rating Option" // ratings option
    @State private var notes: String = "" // notes input
    
    // New state for alert
    @State private var showConfirmationAlert = false
    
    var body: some View {
        VStack {
            VStack(spacing: 20) {
                Text("Daily Workout Log")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top)
                
                VStack(spacing: 10) {
                    // Date Picker Button
                    HStack {
                        Text("Select Date:")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding()
                        
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
                .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack(spacing: 10) {
                    // Split Button
                    HStack {
                        Text("Split: ")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding()
                            .padding(23)
                        
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
                            .padding()
                        }
                    }
                }.frame(maxWidth: .infinity, alignment: .leading)
                
                
                VStack(spacing: 10) {
                    // Duration
                    HStack {
                        Text("Duration: ")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding()
                        
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
                        .padding()
                        
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
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack(spacing: 10) {
                    // Rating Options
                    HStack {
                        Text("Rating: ")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(42)
                        
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
                .frame(maxWidth: .infinity, alignment: .leading)
                
                // notes section
                VStack (alignment: .leading, spacing: 10) {
                    Text("  Notes/Comments: ")
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
                
            }
            Spacer()
            
            
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
            .alert("Workout Submitted!", isPresented: $showConfirmationAlert) {
                Button("OK", role: .cancel) {}
            }
            
            
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
        do {
                try viewContext.save()
                showConfirmationAlert = true
                print("Workout saved successfully.")
            } catch {
                // Handle the Core Data error appropriately
                print("Failed to save workout")
            }
        workoutData.workoutRecords.append(newRecord) // save to shared data
        showConfirmationAlert = true
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
        .environmentObject(WorkoutData()) // Inject the environment object
}
