//
//  ProgressView.swift
//  Fitness App
//

import SwiftUI

struct ProgressView: View {
    
    // Saved Workouts
    @EnvironmentObject var savedWorkouts: SavedWorkouts
    
    // MARK: - Body
    var body: some View {
        
        if(savedWorkouts.workoutArray.isEmpty) {
            EmptyListView()
                .navigationTitle("Progress")
        } else {
            List {
                ForEach(savedWorkouts.workoutArray.reversed()) { entry in
                    ProgressRow(date: entry.date.formatted(date: .abbreviated, time: .omitted), exercises: entry.exercises, time: entry.duration.timeString().minutes, day: entry.date.formatted(.dateTime.weekday(.short)))
                }
                .onDelete(perform: removeRows)
                .listRowBackground(Color.DSOverlay)
            }
            .navigationTitle("Progress")
            .background(Color.DSBackground)
            .scrollContentBackground(.hidden)
            .toolbar {
                EditButton()
            }

        }
    }
    // MARK: - Functions
    
    func removeRows(at offsets: IndexSet) {
        savedWorkouts.workoutArray.remove(atOffsets: offsets)
    }
        
}

// MARK: - Empty List View
struct EmptyListView: View {
    var body: some View {
        VStack {
            Image(systemName: "eyes")
                .foregroundColor(Color.DS_Light)
                .font(.title)
            Text("No workouts yet")
                .padding()
                .foregroundColor(Color.DS_Light)
                .font(.title2)
        }
    }
}



// MARK: - Preview
struct ProgressView_Previews: PreviewProvider {
    
    static let previewObject = SavedWorkouts()
    
    static var previews: some View {
        ProgressView()
            .environmentObject(previewObject)
    }
}
