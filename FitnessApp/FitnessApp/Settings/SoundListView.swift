//
//  SoundList.swift
//  Fitness App
//

import SwiftUI
import AVFoundation

struct SoundListView: View {
    
    // User Info
    @EnvironmentObject var userObject: UserObject
    
    let sounds = ["Attention", "Bell-One"]
    
    @State private var isPlaying = false
    @State private var selection: String?
    
    var body: some View {
        List(sounds, id: \.self, selection: $selection) { sound in
            HStack {
                if (selection == sound) {
                    Image(systemName: "checkmark")
                        .bold()
                }
                Text("\(sound)")
                Spacer()
            }
            .onChange(of: selection) { newValue in
                selection(value: newValue!)
            }
            .listRowBackground(Color.Layer3)
        }
        .background(Color.Layer1)
        .scrollContentBackground(.hidden)
        .navigationTitle("Sounds")
        
    }
    
    func selection(value: String) {
        AudioPlayer.playSound(soundFile: value)
        userObject.props.restTimerSound = value
    }
    
}

// MARK: - Preview
struct SoundListView_Previews: PreviewProvider {
    static var previews: some View {
        SoundListView()
            .environmentObject(UserObject())
    }
}
