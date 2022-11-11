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
            ZStack {
                
                Color.DS_Background
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    
                    // MARK: - Titel
                    HStack {
                        Text("Dashboard")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        Spacer()
                        NavigationLink(destination: SettingsView()) {
                            Image(systemName: "gear")
                                .font(.title)
                                .tint(Color.DS_Primary)
                        }
                    }
                    .padding()
                    
                    
                    
                    // MARK: - WeekView
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Aktivität")
                                .font(.title3)
                                .bold()
                            
                            Spacer()
                            
                            NavigationLink(destination: ProgressView(), isActive: $isShowingProgressView) { EmptyView() }
                            Button("Verlauf") { isShowingProgressView = true }
                                .tint(Color.DS_Light)
                                .font(.body.weight(.medium))
                        }
                        
                        WeekView()
                        
                    }
                    .padding()
                    
                    Spacer()
                    
                    VStack {
                        // MARK: - Stats
                        
                        CurrentStatsView()
                            .padding(.bottom)
                        
                        // MARK: - Workout Buttton
                        HStack(spacing: -10) {
                            
                            NavigationLink(destination: WorkoutView(), isActive: $isShowingWorkoutView) { EmptyView() }
                            MainButton(text: "Starte Workout",icon: "arrow.right") { isShowingWorkoutView = true }
                            
                            Text("\(savedWorkouts.workoutArray.count)")
                                .fontWeight(.bold)
                                .padding(20)
                                
                                
                        }
                        .background(Color.DS_Background)
                        .cornerRadius(20)
                        .padding([.leading,.trailing])
                        
                        
                        
                        Spacer()
                        
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.DS_Overlay)
                    .cornerRadius(40)
                    
                    
                } // End Main VStack
            }.ignoresSafeArea(.all, edges: .bottom)
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
