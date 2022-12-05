//
//  SoundList.swift
//  Fitness App
//

import SwiftUI
import AVFoundation

struct SoundListView: View {
    
    @State var tap = false
    
    var body: some View {
        List {
            Section("Click to listen to sound") {
                Text("Sound 1")
                    .contentShape(Rectangle())
                    .listRowBackground(tap ? Color.DS_Light : Color.DSOverlay)
                    .onTapGesture {
                        withAnimation {
                            tap.toggle()
                        }
                        AudioPlayer.playSound(soundfile: "Bell.mp3")
                    }
            }
            
        }
        .background(Color.DSBackground)
        .scrollContentBackground(.hidden)
    }

}

struct SoundListView_Previews: PreviewProvider {
    static var previews: some View {
        SoundListView()
    }
}
