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
