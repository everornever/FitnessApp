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
                                .tint(Color.DSPrimary)
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
                                .tint(Color.DSLight)
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
