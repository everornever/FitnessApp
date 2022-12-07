//
//  SoundList.swift
//  Fitness App
//

import SwiftUI
import AVFoundation

struct SoundListView: View {
    
    // User Info
    @ObservedObject var user = User()
    
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
            .listRowBackground(Color.DSSecondaryOverlay)
        }
        .background(Color.DSSecondaryBackground)
        .scrollContentBackground(.hidden)
        .navigationTitle("Sounds")
        
    }
    
    func selection(value: String) {
        AudioPlayer.playSound(soundFile: value)
        user.pauseTimerSound = value
    }
    
}

struct SoundListView_Previews: PreviewProvider {
    static var previews: some View {
        SoundListView()
    }
}
