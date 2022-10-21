//
//  ProgressView.swift
//  GetMoving
//
//  Created by Leon Kling on 27.08.22.
//

import SwiftUI

struct ProgressView: View {
    
    @EnvironmentObject var savedWorkouts: SavedWorkouts
    
    var body: some View {
        if(savedWorkouts.workoutArray.isEmpty) {
            VStack {
                Image(systemName: "eyes")
                    .foregroundColor(.secondary)
                    .font(.title)
                Text("Noch keine Workouts")
                    .padding()
                    .foregroundColor(.secondary)
                    .font(.title2)
            }
            .navigationTitle("Verlauf")
        } else {
            List {
                ForEach(savedWorkouts.workoutArray) { entry in
                    HStack {
                        Image(systemName: "clock")
                        Text(entry.duration.timeString().minutes)
                        Spacer()
                        Text(entry.date.formatted(date: .abbreviated, time: .omitted))
                    }
                }
                .onDelete(perform: removeRows)
            }
            .navigationTitle("Verlauf")
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


// MARK: - Preview
struct ProgressView_Previews: PreviewProvider {
    
    static let myEnvObject = SavedWorkouts()
    
    static var previews: some View {
        ProgressView()
            .environmentObject(myEnvObject)
    }
}
