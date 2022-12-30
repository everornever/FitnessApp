//
//  SettingsView.swift
//  Fitness App
//

import SwiftUI

struct SettingsView: View {
    
    // User Info
    @EnvironmentObject var user: UserObject
    
    // Pause Timer
    @State private var allowNotification = false
    let timers = [ 60.0, 90.0, 120.0, 150.0, 180.0]
    
    // App Version
    let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "No version"
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            Form {
                // MARK: - Workout
                Section("Workout") {
                    
                    Toggle(isOn: $user.includeWarmup) {
                        Label("Include warm up", systemImage: "figure.run")
                    }
                        .tint(Color.DSAccent)
                    
                    Toggle(isOn: $user.includeStretching) {
                        Label("Include stretching", systemImage: "figure.cooldown")
                    }
                        .tint(Color.DSAccent)
                    
                    VStack(alignment: .leading) {
                        Label("Rest timer length in minutes", systemImage: "hourglass")
                        Text("")
                        Picker("Rest Timer Length", selection: $user.pauseTimer) {
                            ForEach(timers, id: \.self) {
                                Text(($0 / 60.0).formatted())
                            }
                        }
                        .pickerStyle(.segmented)
                    }

                }
                .listRowBackground(Color.DSSecondaryOverlay)
                
                // MARK: - Notification
                Section("Notification") {
                    NavigationLink(destination: SoundListView()) {
                        Label("Rest timer sound", systemImage: "speaker.wave.2")
                    }
                }
                .listRowBackground(Color.DSSecondaryOverlay)
                
                // MARK: - Testing
                Section("For testing only") {
                    NavigationLink(destination: DebugView()) {
                        Label("Add Workouts", systemImage: "ant")
                            .foregroundColor(Color.DSPrimary)
                    }
                }
                .foregroundColor(.red)
                .listRowBackground(Color.DSSecondaryOverlay)
                
                // MARK: - About
                Section("About us") {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Fitness App \(appVersion)")
                            .font(.headline)
                        Text("Designed with 🤍 in Potsdam")
                            .font(.footnote)
                    }.padding(.vertical, 5)
                }
                .listRowBackground(Color.DSSecondaryOverlay)
            }
            .background(Color.DSSecondaryBackground)
            .scrollContentBackground(.hidden)
            .navigationBarTitle("Settings", displayMode: .inline)
        }
        
    }
}


// MARK: - Preview
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(UserObject())
    }
}
