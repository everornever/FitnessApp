//
//  PauseFunctions.swift
//  Fitness App
//

import Foundation
import Combine
import SwiftUI
import UserNotifications

class PauseTimerFunctions: ObservableObject {
    
    // MARK: - Values
    
    // User Info
    @EnvironmentObject var user: UserObject
    
    // Notification
    private let id = UUID().uuidString
    private let center = UNUserNotificationCenter.current()
    private let content = UNMutableNotificationContent()

    // Timer
    private var startTime: Date?
    private var accumulatedTime: TimeInterval = 0
    private var timer: Cancellable?
    
    // value to be read for UI
    @Published private(set) var timeLeft: TimeInterval = UserObject().pauseTimer
    
    
    // MARK: - Functions
    
    // starts Timer and will stop after time runs up
    func start() {
        self.timer?.cancel() // is this needed ?
        
        createNotification()
        
        self.timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect().sink { _ in
            if (self.timeLeft > 0) {
                self.timeLeft = self.user.pauseTimer + self.getElapsedTime()
            }
            else {
                self.stop()
            }
        }
        
        self.startTime = Date()
    }
    
    // will cancel AND reset any existing timer
    func stop() {
        self.timer?.cancel()
        self.timer = nil
        self.startTime = nil
        self.accumulatedTime = 0
        self.timeLeft = user.pauseTimer
        cancelPendingNotification()
    }
    
    // the start time is in the past, there is a negative time span “since” then and now.
    private func getElapsedTime() -> TimeInterval {
        return self.startTime?.timeIntervalSinceNow ?? 0
    }
    
    private func createNotification() {
        // Content
        content.title = "Keep it going!"
        content.subtitle = "Your rest time is over"
        content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "\(user.pauseTimerSound).m4r"))
        
        // trigger
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: user.pauseTimer, repeats: false)
        
        // request
        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
        
        // adds notification
        center.add(request)
    }
    
    private func cancelPendingNotification() {
        center.removePendingNotificationRequests(withIdentifiers: [id])
        // center.removeAllDeliveredNotifications()
    }
    
}

