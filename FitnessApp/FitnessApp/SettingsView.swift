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
        Form {
            Section {
                Text("Break Timer")
                Picker("Pause Timer Length", selection: $user.pauseTimer) {
                    ForEach(timers, id: \.self) {
                        Text(($0 / 60.0).formatted())
                    }
                } 
                .pickerStyle(.segmented)
            } footer: {
                Text("Set how many minutes you want to rest between sets")
            }
            
            Section("About us") {
                VStack(alignment: .leading, spacing: 5) {
                    Text("Fitness App \(appVersion)")
                        .font(.headline)
                    Text("Designed with 🤍 in Potsdam")
                        .font(.footnote)
                }.padding(.vertical, 5)
            }
        }
        .navigationBarTitle("Settings", displayMode: .inline)
        
    }
}


// MARK: - Preview
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

