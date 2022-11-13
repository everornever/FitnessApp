//
//  CurrentWeek.swift
//  GetMoving
//
//  Created by Leon Kling on 23.09.22.
//

import Foundation
import SwiftUI

struct Day {
    let date: Date
    let stringDate: String
    let dayName: String
    let workoutDone: Bool
}

class CurrentWeek {
    
    // Calender
    private let date = Date()
    private var calendar = Calendar.current
    
    // User Defaults Workouts
    @ObservedObject var savedWorkouts = SavedWorkouts()
    
    // MARK: - Main Function
    func getCurrentWeek() -> [Day] {
        
        var week = [Day]()
        
        for index in 0...6 {
            week.append(Day(date: getDate(atIndex: index),stringDate: getStringDate(atIndex: index), dayName: getName(atIndex: index), workoutDone: getworkout(atIndex: index)))
        }
        
        return week
    }
    
    
    private func getDate(atIndex: Int) -> Date {
        
        // Initial Values
        let monday = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date))!
        let lastSunday = calendar.date(byAdding: .day, value: -1, to: monday)!
        let sunday = calendar.date(byAdding: .day, value: 6, to: monday)!
        
        /// maps out every day starting Monday with its date until next Sunday
        let dates = calendar.range(of: .weekday, in: .weekOfYear, for: sunday)!.compactMap { calendar.date(byAdding: .day, value: $0, to: lastSunday) }
        
        return dates[atIndex]
    }
    
    private func getName(atIndex: Int) -> String {
        
        let shortWeekDays = ["Mo","Tu","We","Th","Fr","Sa","Su"]
        
        return shortWeekDays[atIndex]
    }
    
    private func getStringDate(atIndex: Int) -> String {
        
        let date = getDate(atIndex: atIndex)
        
        // formats dates to double diget format (03,04,..)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"

        return dateFormatter.string(from: date)
    }
    
    private func getworkout(atIndex: Int) -> Bool {
     
        let lastWorkouts = savedWorkouts.workoutArray
        
        let currentDate = getDate(atIndex: atIndex)
        
        var done = false
        
        for ( _ , value) in lastWorkouts.enumerated() {
            if (value.date.formatted(date: .abbreviated, time: .omitted) == currentDate.formatted(date: .abbreviated, time: .omitted)) {
                done = true
                break
            }
        }
        
        return done
    }
}
