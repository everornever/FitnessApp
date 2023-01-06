//
//  SettingsView.swift
//  Fitness App
//

import SwiftUI

struct SettingsView: View {
    
    // User Info
    @EnvironmentObject var userObject: UserObject
    
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
                    
                    Toggle(isOn: $userObject.props.includeWarmup) {
                        Label("Include warm up", systemImage: "figure.run")
                    }
                    .tint(.SingleAccent)
                    
                    Toggle(isOn: $userObject.props.includeStretching) {
                        Label("Include stretching", systemImage: "figure.cooldown")
                    }
                    .tint(.SingleAccent)
                    
                    VStack(alignment: .leading) {
                        Label("Rest timer length in minutes", systemImage: "hourglass")
                        Text("")
                        Picker("Rest Timer Length", selection: $userObject.props.restTimer) {
                            ForEach(timers, id: \.self) {
                                Text(($0 / 60.0).formatted())
                            }
                        }
                        .pickerStyle(.segmented)
                    }

                }
                .listRowBackground(Color.Layer3)
                
                // MARK: - Notification
                Section("Notification") {
                    NavigationLink(destination: SoundListView()) {
                        Label("Rest timer sound", systemImage: "speaker.wave.2")
                            .tint(.SingleAccent)
                    }
                }
                .listRowBackground(Color.Layer3)
                
                // MARK: - Testing
                Section("For testing only") {
                    NavigationLink(destination: DebugView()) {
                        Label("Add Workouts", systemImage: "ant")
                            .tint(.SingleAccent)
                    }
                }
                .foregroundColor(.red)
                .listRowBackground(Color.Layer3)
                
                // MARK: - About
                Section("About us") {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Fitness App \(appVersion)")
                            .font(.headline)
                        Text("Designed with 🤍 in Potsdam")
                            .font(.footnote)
                    }.padding(.vertical, 5)
                }
                .listRowBackground(Color.Layer3)
            }
            .background(Color.Layer1)
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
