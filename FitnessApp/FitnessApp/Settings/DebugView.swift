//
//  DebugView.swift
//  Fitness App
//
//  Created by Leon Kling on 16.12.22.
//

import SwiftUI

struct DebugView: View {
    
    // Saved Workouts
    @EnvironmentObject var savedWorkouts: SavedWorkouts
    
    // Date picker
    @State private var date = Date()
    
    // Stepper
    @State private var value = 0
    
    // Stepper 2
    @State var selection = 1800
    let step = 300
    
    var body: some View {
        List {
            Text("For Testing Only")
                .foregroundColor(.red)
            DatePicker(
                "Start Date",
                selection: $date,
                in: ...Date(),
                displayedComponents: [.date]
            )
            .datePickerStyle(.graphical)
            
            Stepper(value: $value) {
                Text("Exercise Amount: \(value)")
            }
            
            Stepper(value: $selection, step: step) {
                Text("Duration: \(TimeInterval(selection).timeString().minutes)")
            }
            
            Button("Save Workout") {
                // Save
                savedWorkouts.workoutArray.append(Workout(exercises: value, date: date, duration: TimeInterval(selection)))
            }
                .tint(.blue)
            
        }
    }
}

struct DebugView_Previews: PreviewProvider {
    static var previews: some View {
        DebugView()
    }
}