//
//  AudioPlayer.swift
//  Fitness App
//

import Foundation
import AVFoundation

class AudioPlayer {
    
    static var audioPlayer: AVAudioPlayer?
    
    static func playSound(soundFile: String) {
        
        let audioSession = AVAudioSession.sharedInstance()
        
        do {
            try audioSession.setCategory(.playback, mode: .default, options: [.mixWithOthers])
        } catch {
            print("Failed to set audio session category.")
        }

        if let path = Bundle.main.path(forResource: "\(soundFile).m4r", ofType: nil) {
            
            do {
                try audioSession.setActive(true)
            }  catch {
                print("couldn't set session")
            }
            
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                audioPlayer?.play()
            } catch {
                print("couldn't load file :(")
            }
        }
    }
}
