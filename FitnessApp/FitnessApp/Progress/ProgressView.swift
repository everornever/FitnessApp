//
//  ProgressView.swift
//  Fitness App
//

import SwiftUI

struct ProgressView: View {
    
    // Saved Workouts
    @EnvironmentObject var workouts: WorkoutObject
    
    // MARK: - Body
    var body: some View {
        
        if(workouts.savedWorkouts.isEmpty) {
            EmptyListView()
                .navigationTitle("Progress")
        } else {
            List {
                ForEach(workouts.savedWorkouts) { entry in
                    ProgressRow(date: entry.date.formatted(date: .abbreviated, time: .omitted), exercises: entry.exercises, time: entry.duration.timeString().minutes, day: entry.date.formatted(.dateTime.weekday(.short)), weeknumber: String(entry.date.getWeekNumber()))
                }
                .onDelete(perform: removeRows)
                .listRowBackground(Color.DSOverlay)
            }
            .navigationTitle("Progress")
            .background(Color.DSSecondaryBackground)
            .scrollContentBackground(.hidden)
            .toolbar {
                EditButton()
            }

        }
    }
    // MARK: - Functions
    
    func removeRows(at offsets: IndexSet) {
        workouts.savedWorkouts.remove(atOffsets: offsets)
    }
        
}

// MARK: - Empty List View
struct EmptyListView: View {
    var body: some View {
        VStack {
            Image(systemName: "eyes")
                .foregroundColor(Color.DSLight)
                .font(.title)
            Text("No workouts yet")
                .padding()
                .foregroundColor(Color.DSLight)
                .font(.title2)
        }
    }
}



// MARK: - Preview
struct ProgressView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressView()
            .environmentObject(WorkoutObject())
    }
}
