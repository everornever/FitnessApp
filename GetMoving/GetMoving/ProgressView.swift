//
//  ProgressView.swift
//  GetMoving
//
//  Created by Leon Kling on 27.08.22.
//

import SwiftUI

struct ProgressView: View {
    
    @ObservedObject var savedWorkouts = SavedWorkouts()
    
    @State private var showingSheet = false
    @State private var pressedItem = 0
    
    var body: some View {
        if(savedWorkouts.workoutArray.isEmpty) {
            VStack {
                Image(systemName: "eyes")
                    .foregroundColor(.secondary)
                    .font(.title)
                Text("No workouts yet")
                    .padding()
                    .foregroundColor(.secondary)
                    .font(.title2)
            }
            .navigationTitle("Progress")
        } else {
            List {
                ForEach(savedWorkouts.workoutArray) { entry in
                    HStack {
                        Image(systemName: "clock")
                        Text(entry.duration)
                        Spacer()
                        Text(entry.date)
                    }
                }
                .onDelete(perform: removeRows)
                .onTapGesture {
                    showingSheet.toggle()
                }
            }
            .navigationTitle("Progress")
            .toolbar {
                EditButton()
            }
            .sheet(isPresented: $showingSheet) {
                WorkoutDetailView(date: "Passed Date")
            }
            .onAppear{ // this needs to be added because the workoutView List modifier removes list backgrounds
                UITableView.appearance().backgroundColor = .secondarySystemBackground
            }
        }
    }
    
    func removeRows(at offsets: IndexSet) {
        savedWorkouts.workoutArray.remove(atOffsets: offsets)   // not sure if this works correct ??
    }
}

// New View, might be good in new File!
struct WorkoutDetailView: View {
    
    // for the SheetView Dismiss
    @Environment(\.dismiss) var dismiss
    
    let date: String
    
    var body: some View {
        Text("Workout from: \(date)")
        Button("Dismiss") {
            dismiss()
        }
    }
}

struct ProgressView_Previews: PreviewProvider {
    
    static var previews: some View {
        ProgressView()
    }
}
