//
//  PauseFunctions.swift
//  GetMoving
//
//  Created by Leon Kling on 06.10.22.
//

import Foundation
import Combine
import AVFoundation
import SwiftUI
import UserNotifications

class PauseFunctions: ObservableObject {
    
    // MARK: - Values
    
    // User Settings
    @ObservedObject var user = User()
    
    // Timer Sound
    private let systemSoundID: SystemSoundID = 1031
    
    // Notification
    private let id = UUID().uuidString
    private let center = UNUserNotificationCenter.current()
    private let content = UNMutableNotificationContent()

    
    // Timer
    private var startTime: Date?
    private var accumulatedTime: TimeInterval = 0
    private var timer: Cancellable?
    
    /// value to be read for UI
    @Published private(set) var timeLeft: TimeInterval = User().pauseTimer
    
    
    // MARK: - Functions
    
    // starts Timer and will stop after time runs up
    ///  Timers are not presice, at a rate of 0.5 seconds we souldn't see any bugs
    func start() {
        self.timer?.cancel() // is this needed ?
        
        createNotification()
        
        self.timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect().sink { _ in
            if (self.timeLeft > 0) {
                self.timeLeft = self.user.pauseTimer + self.getElapsedTime()
            }
            else {
                self.playSound()
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
    
    /// the start time is in the past, there is a negative time span “since” then and now.
    private func getElapsedTime() -> TimeInterval {
        return self.startTime?.timeIntervalSinceNow ?? 0
    }
    
    // plays Timer Sound
    func playSound() {
        AudioServicesPlaySystemSound(systemSoundID)
    }
    
    // will make and plan a Notification
    func createNotification() {
        // Content
        content.title = "Pause ist vorbei"
        content.subtitle = "zurück an die Arbeit!"
        content.sound = UNNotificationSound.default
        
        // trigger
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: user.pauseTimer, repeats: false)
        
        // request
        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
        
        // adds notification
        center.add(request)
    }
    
    // cancels pending notification
    func cancelPendingNotification() {
        center.removePendingNotificationRequests(withIdentifiers: [id])
        center.removeAllDeliveredNotifications()
    }
    
}

