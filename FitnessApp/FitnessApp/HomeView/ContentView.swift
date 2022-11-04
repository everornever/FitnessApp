//
//  ContentView.swift
//  GetMoving
//
//  Created by Leon Kling on 25.08.22.
//

import SwiftUI

struct ContentView: View {
    
    // Important: StateObject = First creation of Object!
    @StateObject var savedWorkouts = SavedWorkouts()
    @StateObject var user = User()
    
    @State private var isShowingProgressView = false
    @State private var isShowingWorkoutView = false
    @State private var isShowingUpdateView = false
    
    let appVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
    
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
                
                // MARK: - Workout Buttton
                VStack(alignment: .leading) {
                    
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
        .onAppear(perform: checkForUpdates)
        .environmentObject(savedWorkouts)
        .fullScreenCover(isPresented: $user.firstStart, content: { Onboarding(showOnboarding: $user.firstStart) })
        .sheet(isPresented: $isShowingUpdateView) { UpdateView() }
    }
    
    func checkForUpdates() {
        print("Last Version:", user.lastVersion)
        print("Current Version:" ,appVersion)
        
        if(user.lastVersion != appVersion) {
            isShowingUpdateView = true
        }
    }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
