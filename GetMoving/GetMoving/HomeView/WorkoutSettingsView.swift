//
//  StreakView.swift
//  GetMoving
//
//  Created by Leon Kling on 04.10.22.
//

import SwiftUI

struct WorkoutSettingsView: View {
    
    @StateObject var user = User()
    
    let timers = [ 60.0, 90.0, 120.0, 150.0, 180.0]
    
    var body: some View {
        VStack {
            Text("Pausen Zeit in Minuten")
                .font(.body)
                .foregroundColor(.secondary)
            Picker("Pause Timer Length", selection: $user.pauseTimer) {
                ForEach(timers, id: \.self) {
                    Text(($0 / 60.0).formatted())
                }
            }
            .pickerStyle(.segmented)
            
            HStack {
                Toggle("   Mit Warmup", isOn: $user.includeWormup)
                    .background(.white)
                    .cornerRadius(15)
                Toggle("   Mit Dehnen", isOn: $user.includeStreching)
                    .background(.white)
                    .cornerRadius(15)
            }
            .padding(.top)
            
        }
        .padding()
        .background(.thinMaterial)
        .cornerRadius(20)
    }
}

struct WorkoutSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutSettingsView()
    }
}
