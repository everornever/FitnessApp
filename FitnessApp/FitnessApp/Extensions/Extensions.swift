//
//  TimeExtension.swift
//  GetMoving
//
//  Created by Leon Kling on 16.10.22.
//

import Foundation
import SwiftUI

extension Double {
    
    // Convert the time into 24hr (24:00:00) format
    // hours returns 00:00:00
    // minutes returns 00:00
    func timeString() -> (hours: String, minutes: String, seconds: String) {
        let hours   = Int(self) / 3600
        let minutes = Int(self) / 60 % 60
        let seconds = Int(self) % 60
        return (String(format:"%02i:%02i:%02i", hours, minutes, seconds),
                String(format:"%02i:%02i", hours, minutes),
                String(format:"%02i:%02i", minutes, seconds))
    }
}

