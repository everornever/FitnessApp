//
//  StopwatchFunctions.swift
//  Fitness App
//

import Combine
import Foundation

class StopwatchFunctions: ObservableObject {
    
    private var startTime: Date?
    private var timer: Cancellable?
    
    // MARK: - Publisher
    @Published private(set) var elapsedTime: TimeInterval = 0
    
    @Published var isRunning = false {
        didSet {
            if self.isRunning {
                self.start()
            } else {
                self.stop()
            }
        }
    }
    
    // MARK: - Functions
    
    // start timer
    private func start() -> Void {
        self.timer?.cancel()
        self.timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect().sink { _ in
            self.elapsedTime = self.getElapsedTime()
        }
        self.startTime = Date()
    }
    
    
    // will cancel any existing timer
    private func stop() -> Void {
        self.timer?.cancel()
        self.timer = nil
        self.startTime = nil
    }
    
    
    // will set everything to zero. can be called outside of class
    func reset() -> Void {
        self.elapsedTime = 0
        self.startTime = nil
        self.isRunning = false
    }
    
    /// - Description: the start time is in the past, there is a negative time span “since” then and now.
    ///                we use the unary minus operator to change that to a positive value
    /// - Returns:     the timeinterval between startTime and now. with nil-coalescing. plus the already passed time
    private func getElapsedTime() -> TimeInterval {
        return -(self.startTime?.timeIntervalSinceNow ?? 0)
    }
    
}

