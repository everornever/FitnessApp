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
        
        print("Get Dates Methode:")
        
        // Initial Values
        let lastSunday = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date))!
        let thisMonday = calendar.date(byAdding: .day, value: 1, to: lastSunday)!
        let thisSunday = calendar.date(byAdding: .day, value: 6, to: thisMonday)!
        
        print("lastSunday:", lastSunday)
        print("thisMonday:", thisMonday)
        print("thisSunday:", thisSunday)
        
        /// maps out every day starting Monday with its date until next Sunday
        let dates = calendar.range(of: .weekday, in: .weekOfYear, for: thisSunday)!.compactMap { calendar.date(byAdding: .day, value: $0, to: lastSunday) }
        print("Date Array:", dates)
        
        print("Returned:", dates[atIndex])
        return dates[atIndex]
    }
    
    private func getName(atIndex: Int) -> String {
        
        let shortWeekDays = ["Mo","Di","Mi","Do","Fr","Sa","So"]
        
        print("String Name:", shortWeekDays[atIndex])
        return shortWeekDays[atIndex]
        
    }
    
    private func getStringDate(atIndex: Int) -> String {
        
        let date = getDate(atIndex: atIndex)
        
        // formats dates to double diget format (03,04,..)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        
        print("String Date:", dateFormatter.string(from: date))
        return dateFormatter.string(from: date)
        
    }
    
    private func getworkout(atIndex: Int) -> Bool {
     
        let lastWorkouts = savedWorkouts.workoutArray
        
        let currentDate = getDate(atIndex: atIndex)
        
        var done = false
        
        // TODO: check for savedWorkouts
        
        for (index, value) in lastWorkouts.enumerated() {
            if (value.date.formatted(date: .abbreviated, time: .omitted) == currentDate.formatted(date: .abbreviated, time: .omitted)) {
                done = true
                break
            }
        }
        
        return done
    }
}
