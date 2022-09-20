//
//  SimpleTimer.swift
//  GetMoving
//
//  Created by Leon Kling on 19.09.22.
//

import Combine
import Foundation
import SwiftUI

class SimpleTimer: ObservableObject {
    
    private var startTime: Date?
    private var accumulatedTime:TimeInterval = 0
    private var timer: Cancellable?
    
    @Published var isRunning = false {
        didSet {
            if self.isRunning {
                self.start()
            } else {
                self.stop()
            }
        }
    }
    
    @Published private(set) var elapsedTime: TimeInterval = 0
    private func start() -> Void {
        self.startTime = Date()
        self.timer?.cancel()
        self.timer = Timer.publish(every: 0.5, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                self.elapsedTime = self.getElapsedTime()
            }
    }
    
    private func stop() -> Void {
        self.timer?.cancel()
        self.timer = nil
        self.accumulatedTime = self.getElapsedTime()
        self.startTime = nil
    }
    
    func reset() -> Void {
        self.accumulatedTime = 0
        self.elapsedTime = 0
        self.startTime = nil
        self.isRunning = false
    }
    
    private func getElapsedTime() -> TimeInterval {
        return -(self.startTime?.timeIntervalSinceNow ??     0)+self.accumulatedTime
    }
}
