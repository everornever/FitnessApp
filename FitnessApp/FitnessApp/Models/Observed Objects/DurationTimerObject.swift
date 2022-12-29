//
//  StopwatchFunctions.swift
//  Fitness App
//

import Combine
import Foundation

class DurationTimerObject: ObservableObject {
    
    // Timer
    private var startTime: Date?
    private var timer: Cancellable?
    
    // value to be read for UI
    @Published private(set) var elapsedTime: TimeInterval = 0

    
    // MARK: - Functions
    
    // start timer
    func start() {
        self.timer?.cancel()
        
        self.timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect().sink { _ in
            self.elapsedTime = self.getElapsedTime()
        }
        self.startTime = Date()
    }
    
    // will cancel AND reset any existing timer
    func stop() {
        self.timer?.cancel()
        self.timer = nil
        self.startTime = nil
    }
    
    // the start time is in the past, there is a negative time span “since” then and now.
    private func getElapsedTime() -> TimeInterval {
        return -(self.startTime?.timeIntervalSinceNow ?? 0)
    }
    
}

