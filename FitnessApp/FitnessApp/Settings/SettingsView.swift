//
//  SettingsView.swift
//  Fitness App
//

import SwiftUI

struct SettingsView: View {
    
    // User info
    @ObservedObject var user = User()
    
    // Pause Timer
    @State private var allowNotification = false
    let timers = [ 60.0, 90.0, 120.0, 150.0, 180.0]
    
    // App Version
    let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "No version"
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            Form {
                Section("Workout") {
                    VStack(alignment: .leading) {
                        Text("Pause timer length in minutes")
                        Picker("Pause Timer Length", selection: $user.pauseTimer) {
                            ForEach(timers, id: \.self) {
                                Text(($0 / 60.0).formatted())
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                    
                    Toggle("Include warm up", isOn: $user.includeWarmup)
                        .tint(Color.DSAccent)
                    
                    Toggle("Include stretching", isOn: $user.includeStretching)
                        .tint(Color.DSAccent)

                }
                .listRowBackground(Color.DSSecondaryOverlay)
                
                Section("Notification") {
                    NavigationLink(destination: SoundListView()) {
                        Text("Pause timer sound")
                    }
                }
                .listRowBackground(Color.DSSecondaryOverlay)
                
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
    }
}
