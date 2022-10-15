//
//  SettingsView.swift
//  GetMoving
//
//  Created by Leon Kling on 25.08.22.
//

import SwiftUI
import UserNotifications

// User writes settings to Userdefaults with @AppStorage
// Might be good to make new File
// turn this into a dictionary ??
class User: ObservableObject {
    @AppStorage("name") var name = ""
    @AppStorage("weight") var weight = 00.00
    @AppStorage("numberOfExercises") var numberOfExercises = 6
    @AppStorage("numberOfSets") var numberOfSets = 3
    @AppStorage("pauseTimer") var pauseTimer = 1.50
}

struct SettingsView: View {
    
    @StateObject var user = User()
    
    @FocusState private var inputIsFocused: Bool
    
    // Pause Timer
    @State private var allowNotification = false
    let timers = [ 1.00, 1.50, 2.00, 2.50, 3.00]
    
    var body: some View {
        Form {
            Section("Dein Name") {
                HStack {
                    Image(systemName: "person")
                    TextField("Name", text: $user.name) {
                        UserDefaults.standard.set(user.name, forKey: "name")
                    }
                    .keyboardType(.default)
                    .focused($inputIsFocused)
                }
            }
            
            Section {
                Picker("Pause Timer Length", selection: $user.pauseTimer) {
                    ForEach(timers, id: \.self) {
                        Text($0.formatted())
                    }
                }
                .pickerStyle(.segmented)
                
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
                Text("Pause Timer in Minuten")
            }
            
            Section(header: Text("Über uns")) {
                VStack(alignment: .leading, spacing: 5) {
                    Text("GetMoving v0.1")
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

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
