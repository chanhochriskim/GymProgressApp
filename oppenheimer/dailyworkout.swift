//
//  dailyworkout.swift
//  oppenheimer
//
//  Created by Chris Kim on 11/24/24.
//

import SwiftUI
import UIKit

struct dailyworkoutview: View {
    @State private var selectedDate = Date() // storing the selectedDate
    @State private var showDatePicker = false // visibility of the calender
    
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Daily Workout Log")
                .font(.largeTitle)
                
            
            // Date Picker Button
            HStack {
                Text("Select Date")
                    .font(.title2)
                    .frame(width: UIScreen.main.bounds.width / 3)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
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
            Spacer()
        }
        .padding()
    }
    
    // helper function to format the date
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}


#Preview {
    dailyworkoutview()
}
