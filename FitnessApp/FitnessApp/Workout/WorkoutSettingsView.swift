//
//  WorkoutSettingsView.swift
//  Fitness App
//
//  Created by Leon Kling on 07.01.23.
//

import SwiftUI

struct WorkoutSettingsView: View {
    
    // User Info
    @EnvironmentObject var userObject: UserObject
    
    let timers = [ 60.0, 90.0, 120.0, 150.0, 180.0]
    
    var body: some View {
        List {
            Toggle(isOn: $userObject.props.includeWarmup) {
                Label("Include warm up", systemImage: "figure.run")
            }
            .tint(.SingleAccent)
            
            Toggle(isOn: $userObject.props.includeStretching) {
                Label("Include stretching", systemImage: "figure.cooldown")
            }
            .tint(.SingleAccent)
            
            Toggle(isOn: $userObject.props.disabledSleep) {
                Label("Keep screen awake", systemImage: "lock.iphone")
            }
            .tint(.SingleAccent)
            .onChange(of: userObject.props.disabledSleep) { _isOn in
                UIApplication.shared.isIdleTimerDisabled.toggle()
                print("Sleep mode toggel")
            }
            
            Section {
                Label("Rest timer length in minutes", systemImage: "hourglass")
                Picker(selection: $userObject.props.restTimer, label: Label("Test", systemImage: "")) {
                    ForEach(timers, id: \.self) {
                        Text(($0 / 60.0).formatted())
                    }
                }
                .pickerStyle(.segmented)
            }
            
        }
        .listStyle(.inset)
        .padding()
    }
}

struct WorkoutSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutSettingsView()
            .environmentObject(UserObject())
    }
}
