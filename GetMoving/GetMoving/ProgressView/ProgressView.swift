//
//  ProgressView.swift
//  GetMoving
//
//  Created by Leon Kling on 27.08.22.
//

import SwiftUI

struct ProgressView: View {
    
    @EnvironmentObject var savedWorkouts: SavedWorkouts
    
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
                        Text(timeString(time: entry.duration).minutes)
                        Spacer()
                        Text(entry.date.formatted(date: .abbreviated, time: .omitted))
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
                ProgressDetailView(date: "Passed Date")
            }
        }
    }
    
    func removeRows(at offsets: IndexSet) {
        savedWorkouts.workoutArray.remove(atOffsets: offsets)
    }
    
    // make extension!!
    // Convert the time into 24hr (24:00:00) format
    // hours returns 00:00:00
    // minutes returns 00:00
    func timeString(time: Double) -> (hours: String, minutes: String, seconds: String) {
        let hours   = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return (String(format:"%02i:%02i:%02i", hours, minutes, seconds),
                String(format:"%02i:%02i", hours, minutes),
                String(format:"%02i:%02i", minutes, seconds))
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
