//
//  ContentView.swift
//  oppenheimer
//
//  Created by Chris Kim on 11/24/24.
//
//
import SwiftUI

struct ContentView: View {
    @StateObject private var workoutData = WorkoutData() // shared data model
    let persistenceController = PersistenceController.shared
    
    
    var body: some View {
        NavigationView {
            
            // Top section
            VStack(spacing: 20) {
                HStack {
                    Image("Icon 1")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        
                    Text("OPPENHËIMER")
                        .font(.system(size: 27, weight: .bold, design: .serif)) // customize font-style
                        .padding()
                        .frame(maxWidth: .infinity)

                    Spacer() // pushing content to the left
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.gray) // background color for the top section
                
                Spacer() // Space between top and buttons
                // Button Stack
                VStack(spacing: 20) {
                    
                    // Button for dailyworkout (2-1)
                    NavigationLink(destination: DailyWorkoutView()
                        .environment(\.managedObjectContext, persistenceController.container.viewContext)) {
                        Text("Daily Workout")
                            .font(.title2)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.yellow)
                            .foregroundColor(.black)
                            .cornerRadius(120)
                    }
                    .padding(.horizontal)
                    
                    // Button for dashboard (2-2)
                    NavigationLink(destination: DashboardView()
                        .environment(\.managedObjectContext, persistenceController.container.viewContext)) {
                        Text("Dashboard")
                            .font(.title2)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.black)
                            .foregroundColor(.yellow)
                            .cornerRadius(120)
                    }
                    .padding(.horizontal)
                }
                Spacer() // space at the bottom
                
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
