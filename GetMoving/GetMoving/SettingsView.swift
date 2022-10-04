//
//  SettingsView.swift
//  GetMoving
//
//  Created by Leon Kling on 25.08.22.
//

import SwiftUI

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
            } header: {
                Text("Pause Timer in Minuten")
            }
            
            Section("Konfiguriere dein Workout") {
                Stepper("Übungen: \(user.numberOfExercises)", value: $user.numberOfExercises, in: 1...12)
                
                Stepper("Sets: \(user.numberOfSets)", value: $user.numberOfSets, in: 1...12)
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
