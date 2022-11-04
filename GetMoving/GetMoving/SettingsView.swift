//
//  SettingsView.swift
//  GetMoving
//
//  Created by Leon Kling on 25.08.22.
//

import SwiftUI
import UserNotifications

struct SettingsView: View {
    
    @StateObject var user = User()
    
    // Keyboard
    @FocusState private var inputIsFocused: Bool
    
    // Pause Timer
    @State private var allowNotification = false
    let timers = [ 60.0, 90.0, 120.0, 150.0, 180.0]
    
    // App Version
    let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "No version"
    
    var body: some View {
        Form {
            Section("Dein Name") {
                HStack {
                    Image(systemName: "person")
                    TextField("Name", text: $user.name)
                    .keyboardType(.default)
                    .focused($inputIsFocused)
                }
            }
            
            Section {
                Picker("Pause Timer Length", selection: $user.pauseTimer) {
                    ForEach(timers, id: \.self) {
                        Text(($0 / 60.0).formatted())
                    }
                } 
                .pickerStyle(.segmented)
            } header: {
                Text("Pausen Zeit in Minuten")
            } footer: {
                Text("Stelle ein wie viel Minuten du zwischen zwei Satzen Pause machen willst.")
            }
            
            Section {
                Toggle("🚫 Protein Shake", isOn: $user.includeWormup)
                Button("Fuck Notification") {
                    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                        if success {
                            print("All set!")
                        } else if let error = error {
                            print(error.localizedDescription)
                        }
                    }
                }
            } header: {
                Text("Mitteilungen")
            } footer: {
                Text("Eine Erinnerung 30 Minuten nach dem Training")
            }
            
            Section("Über uns") {
                VStack(alignment: .leading, spacing: 5) {
                    Text("GetMoving \(appVersion)")
                        .font(.headline)
                    Text("Designed mit 🤍 in Potsdam")
                        .font(.footnote)
                }.padding(.vertical, 5)
            }
        }
        .navigationBarTitle("Settings", displayMode: .inline)
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Done") {
                    inputIsFocused = false
                }
            }
        }
        
    }
}


// MARK: - Preview
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
