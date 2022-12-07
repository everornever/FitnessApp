//
//  AudioPlayer.swift
//  Fitness App
//

import Foundation
import AVFoundation

class AudioPlayer {
    
    static var audioPlayer: AVAudioPlayer?
    
    static func playSound(soundFile: String) {

        if let path = Bundle.main.path(forResource: "\(soundFile).m4r", ofType: nil) {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                audioPlayer?.play()
            } catch {
                print("couldn't load file :(")
            }
        }
    }
}
