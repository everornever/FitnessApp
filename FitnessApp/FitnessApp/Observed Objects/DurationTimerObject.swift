//
//  StopwatchFunctions.swift
//  Fitness App
//

import Combine
import Foundation
import UserNotifications

class DurationTimerObject: ObservableObject {
    
    // Timer
    private var startTime: Date?
    private var timer: Cancellable?
    
    // Notification
    private let id = UUID().uuidString
    private let center = UNUserNotificationCenter.current()
    private let content = UNMutableNotificationContent()
    
    // value to be read for UI
    @Published private(set) var elapsedTime: TimeInterval = 0

    
    // MARK: - Functions
    
    // start timer
    func start() {
        self.timer?.cancel()
        
        createNotification()
        
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
        cancelPendingNotification()
    }
    
    // the start time is in the past, there is a negative time span “since” then and now.
    private func getElapsedTime() -> TimeInterval {
        return -(self.startTime?.timeIntervalSinceNow ?? 0)
    }
    
    private func createNotification() {
        // Content
        content.title = "Are you still working out?"
        content.subtitle = "Your workout is still running"
        content.sound = UNNotificationSound.default
        
        // trigger
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 7200, repeats: false)
        
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

