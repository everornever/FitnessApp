//
//  ContentView.swift
//  Fitness App
//

import SwiftUI

struct ContentView: View {
    
    // User Info
    @EnvironmentObject var userObject: UserObject
    
    // Views
    @State private var isShowingWorkoutView = false
    @State private var isShowingUpdateView = false
    
    // App Version
    let appVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.Layer1
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
                                .tint(Color.primary)
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
                                .tint(Color.SingleLight)
                        }
                        WeekView()
                    }
                    .padding()
                    
                    // MARK: - Overlay
                    VStack(spacing: -10) {
                        CurrentStatsView()
                        
                        NavigationLink(destination: WorkoutView()) {
                            MainLabel(text: "Start Workout", icon: "arrow.right")
                        }
                        .padding()
                        
                        Spacer(minLength: 30)
                        
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color.Layer2)
                    .cornerRadius(40)
                    .shadow(color: Color.gray.opacity(0.1), radius: 10, x: 0, y: -3)
                    
                    
                } // End Main VStack
            }.ignoresSafeArea(.all, edges: .bottom)
        }
        .environmentObject(userObject)
        .onAppear(perform: checkForUpdates)
        .fullScreenCover(isPresented: $userObject.props.firstStart, content: { Onboarding(showOnboarding: $userObject.props.firstStart) })
        .sheet(isPresented: $isShowingUpdateView) { UpdateView(isPresented: $isShowingUpdateView) }
    }
    
    func checkForUpdates() {
        print("Last Version:", userObject.props.lastVersion)
        print("Current Version:" ,appVersion)
        
        if(userObject.props.lastVersion != appVersion && !userObject.props.firstStart ) {
            isShowingUpdateView = true
        }
    }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(UserObject())
        
    }
}
