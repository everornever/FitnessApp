//
//  AudioPlayer.swift
//  Fitness App
//

import Foundation
import AVFoundation

class AudioPlayer {
    
    static var audioPlayer: AVAudioPlayer?
    
    static func playSound(soundfile: String) {

        if let path = Bundle.main.path(forResource: soundfile, ofType: nil) {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                audioPlayer?.play()
                print("Plays Sound")
            } catch {
                print("couldn't load file :(")
            }
        }
    }
}
