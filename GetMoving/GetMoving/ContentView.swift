//
//  ContentView.swift
//  GetMoving
//
//  Created by Leon Kling on 25.08.22.
//

import SwiftUI

struct ContentView: View {
    
    // Important: First creation of Object!
    @StateObject var savedWorkouts = SavedWorkouts()
    
    @State private var isShowingProgressView = false
    @State private var isShowingWorkoutView = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                VStack {
                    HStack {
                        Text("Activity")
                            .font(.headline)
                            .bold()
                            .padding()
                        
                        Spacer()
                        
                        NavigationLink(destination: ProgressView(), isActive: $isShowingProgressView) { EmptyView() }
                        Button("See All") { isShowingProgressView = true }
                            .foregroundStyle(.secondary)
                            .buttonStyle(.bordered)
                            .buttonBorderShape(.capsule)
                            .controlSize(.small)
                            .padding(.trailing)
                    }
                    WeekView()
                }

                VStack(alignment: .leading) {
                    Text("Weekly Stats")
                        .font(.headline)
                        .bold()
                        .padding()
                    
                    WeeklyStats()
                }
                
                VStack(alignment: .leading) {
                    
                    Text("Workout")
                        .font(.headline)
                        .bold()
                        .padding()
                    
                    NavigationLink(destination: WorkoutView(), isActive: $isShowingWorkoutView) { EmptyView() }
                    
                    Button("Start Workout") { isShowingWorkoutView = true }
                        .foregroundStyle(.green)
                        .tint(.green.opacity(0.1))
                        .buttonStyle(.borderedProminent)
                        .buttonBorderShape(.capsule)
                        .controlSize(.large)
                        .frame(maxWidth: .infinity)

                    
                }
                
                Spacer()
            }
            .navigationBarTitle("Home")
            .navigationBarItems(
                trailing:
                    NavigationLink(destination: SettingsView()) {
                        Text("Settings")
                    }
            )
        }
        .environmentObject(savedWorkouts)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
