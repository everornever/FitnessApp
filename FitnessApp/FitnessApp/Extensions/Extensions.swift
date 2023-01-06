//
//  TimeExtension.swift
//  Fitness App
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
        let seconds = (Int(self) > 0) ? Int(self) % 60 : 0
        return (String(format:"%02i:%02i:%02i", hours, minutes, seconds),
                String(format:"%02i:%02i", hours, minutes),
                String(format:"%02i:%02i", minutes, seconds))
    }
    
    func dezimalString() -> String {
        let two = Double(self)
        return String(format: "%0.1.2f", two)
    }
}

extension Binding {
    func onChange(_ handler: @escaping (Value) -> Void) -> Binding<Value> {
        Binding(
            get: { self.wrappedValue },
            set: { newValue in
                self.wrappedValue = newValue
                handler(newValue)
            }
        )
    }
}

extension Date {
    // Get last 6 week Numbers as Strings
    func getLastSixWeeks() -> Array<Int> {
        var weeks = [Int]()
        
        for index in 0...5 {
            let temp = Calendar.current.component(.weekOfYear, from: Calendar.current.date(byAdding: .weekOfYear, value: -index, to: self)!)
            weeks.append(temp)
        }
        
        return weeks.reversed()
    }
}

typealias Key = UserDefaults.Keys

extension UserDefaults {
    static let appGroup = UserDefaults(suiteName: "group.BETA-CODE.FitnessApp")!
    
    enum Keys: String {
        case SavedWorkouts
        case SavedUser
    }
}

