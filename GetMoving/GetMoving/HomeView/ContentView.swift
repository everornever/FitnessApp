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
                // MARK: - WeekView
                VStack(alignment: .leading) {
                    HStack {
                        Text("Aktivität")
                            .font(.headline)
                            .bold()
                        
                        Spacer()
                        
                        NavigationLink(destination: ProgressView(), isActive: $isShowingProgressView) { EmptyView() }
                        Button("Verlauf") { isShowingProgressView = true }
                        
                    }
                    WeekView()
                }
                .padding()
                
                // MARK: - Stats
                VStack(alignment: .leading) {
                    
                    Text("Aktuelle Werte")
                        .font(.headline)
                        .bold()
                    
                    CurrentStatsView()
                    
                }
                .padding()
                
                // MARK: - Workout Settings
                VStack(alignment: .leading) {
                    
                    Text("Workout")
                        .font(.headline)
                        .bold()
                    
                    WorkoutSettingsView()
                    
                    NavigationLink(destination: WorkoutView(), isActive: $isShowingWorkoutView) { EmptyView() }
                    Button { isShowingWorkoutView = true } label: {
                        Text("**Starte Workout**")
                            .frame(maxWidth: .infinity)
                            .foregroundStyle(.black)
                            .font(.title2)
                            .padding(10)
                    }
                    .foregroundStyle(.green)
                    .tint(Color("FirstColor"))
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                    .padding(.top, 20)
                    
                }
                .padding()

            } // End Main VStack
            .navigationBarTitle("Home")
            .navigationBarItems(
                trailing:
                    NavigationLink(destination: SettingsView()) {
                        Image(systemName: "gear")
                            .font(.title3)
                            .tint(.black)
                    }
            )
        }
        .environmentObject(savedWorkouts)
    }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
