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
        let seconds = Int(self) % 60
        return (String(format:"%02i:%02i:%02i", hours, minutes, seconds),
                String(format:"%02i:%02i", hours, minutes),
                String(format:"%02i:%02i", minutes, seconds))
    }
    
    func dezimalString() -> String {
        let two = Double(self)
        return String(format: "%0.1.2f", two)
    }
}

extension Date {
    
    func getWeekNumber() -> Int {
        let calendar = Calendar.current
        let weekNumber = calendar.component(.weekOfYear, from: Date(primitivePlottable: self)!)
        return weekNumber
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

