//
//  ContentView.swift
//  Fitness App
//

import SwiftUI

struct ContentView: View {
    
    // Important: StateObject = First creation of Object!
    @StateObject var savedWorkouts = SavedWorkouts()
    @StateObject var user = User()
    
    // Views
    @State private var isShowingWorkoutView = false
    @State private var isShowingUpdateView = false
    
    let appVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.DSOverlay
                    .ignoresSafeArea()
                
                VStack(spacing: 0) { // Main VStack
                    
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
                    VStack {
                        HStack {
                            Text("Activity")
                                .font(.title3)
                                .bold()
                            
                            Spacer()
                            
                            NavigationLink("See all", destination: ProgressView())
                                .tint(Color.DS_Light)
                        }
                        WeekView()
                    }
                    .padding()
                    
                    // MARK: - Overlay
                    VStack(spacing: -10) {
                        CurrentStatsView()
                        
                        NavigationLink(destination: WorkoutView()) {
                            MainLable(text: "Start Workout",icon: "arrow.right")
                        }
                        .padding()
                        
                        Spacer(minLength: 30)
                        
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color.DSBackground)
                    .cornerRadius(40)
                    
                    
                } // End Main VStack
            }.ignoresSafeArea(.all, edges: .bottom)
        }
        .onAppear(perform: checkForUpdates)
        .environmentObject(savedWorkouts)
        .fullScreenCover(isPresented: $user.firstStart, content: { Onboarding(showOnboarding: $user.firstStart) })
        .sheet(isPresented: $isShowingUpdateView) { UpdateView(isPresented: $isShowingUpdateView) }
    }
    
    func checkForUpdates() {
        print("Last Version:", user.lastVersion)
        print("Current Version:" ,appVersion)
        
        if(user.lastVersion != appVersion && !user.firstStart ) {
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
