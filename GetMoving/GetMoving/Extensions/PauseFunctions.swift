//
//  PauseFunctions.swift
//  GetMoving
//
//  Created by Leon Kling on 06.10.22.
//

import Foundation
import Combine
import AVFoundation

class PauseFunctions: ObservableObject {
    
    // User Settings
    let user = User()
    
    private var startTime: Date?
    private var accumulatedTime: TimeInterval = 0
    private var timer: Cancellable?
    
    private let systemSoundID: SystemSoundID = 1117
    
    /// can only be read outside of class. the final value to puplish the paased time to a UI interface
    @Published private(set) var timeLeft: TimeInterval = 90
    
    /// no need to call functions. we start and stop the stopwatch by manipulating isRunning. functions are private
    @Published var isRunning = false {
        didSet {
            if self.isRunning {
                self.start()
            } else {
                self.stop()
            }
        }
    }
    
    /// first cancelling any existing timer, to create a new one. Timers are not presice, at a rate of 0.5 seconds we don't see any bugs. then the startTime will be set
    /// - Returns: when the timer fires, we call "getElapsedTime" and write passed time to "elapsedTime" to be used in UI
    private func start() -> Void {
        self.timer?.cancel()
        self.timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect().sink { _ in
            if (self.timeLeft > 0) {
                self.timeLeft = 90 + self.getElapsedTime()
            }
            else {
                self.stop()
                self.reset()
            }
        }
        self.startTime = Date()
    }
    
    
    /// will cancel any existing timer
    private func stop() -> Void {
        self.timer?.cancel()
        self.timer = nil
        self.startTime = nil
    }
    
    
    /// will set everything to zero. can be called outside of class
    func reset() -> Void {
        AudioServicesPlaySystemSound(systemSoundID)
        self.accumulatedTime = 0
        self.timeLeft = 90
        self.startTime = nil
        self.isRunning = false
    }
    
    /// - Description: the start time is in the past, there is a negative time span “since” then and now.
    ///                we use the unary minus operator to change that to a positive value
    /// - Returns:     the timeinterval between startTime and now. with nil-coalescing. plus the already passed time
    private func getElapsedTime() -> TimeInterval {
        return self.startTime?.timeIntervalSinceNow ?? 0
    }
    
}

