//
//  SettingsView.swift
//  Fitness App
//

import SwiftUI

struct SettingsView: View {
    
    // User info
    @StateObject var user = User()
    
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
                        .tint(Color.DS_Accent)
                    
                    Toggle("Include stretching", isOn: $user.includeStreching)
                        .tint(Color.DS_Accent)

                }
                .listRowBackground(Color.DSOverlay)
                
                Section("Notification") {
                    NavigationLink(destination: SoundListView()) {
                        Text("Pause timer sounds")
                    }
                }
                .listRowBackground(Color.DSOverlay)
                
                Section("About us") {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Fitness App \(appVersion)")
                            .font(.headline)
                        Text("Designed with 🤍 in Potsdam")
                            .font(.footnote)
                    }.padding(.vertical, 5)
                }
                .listRowBackground(Color.DSOverlay)
            }
            .background(Color.DSBackground)
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
