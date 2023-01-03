//
//  CurrentWeek.swift
//  Fitness App
//

import Foundation
import SwiftUI

class CurrentWeek {
    
    // This should automatically take the right calendar for the user's locale
    private var calendar = Calendar.current
    
    // Saved Workouts
    @ObservedObject var workouts = WorkoutObject()
    
    // MARK: - Main Function
    func getCurrentWeek() -> [Day] {
        
        var week = [Day]()
        
        for index in 0..<7 {
            week.append(Day(date: getDate(atIndex: index),stringDate: getStringDate(atIndex: index), dayName: getName(atIndex: index), workoutDone: getWorkout(atIndex: index)))
        }
        
        return week
    }
    
    // get current target amount
    func getWorkoutsDoneAmount() -> Int {
        
        let week = getCurrentWeek()
        var amount = 0
        
        for index in week {
            if (index.workoutDone == true) {
                amount += 1
            }
        }
        return amount
    }
    
    private func getDate(atIndex: Int) -> Date {
        
        let startOfCurrentWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date()))
        
        var weekDates: [Date] = []
        
        for i in 0..<7 {
            weekDates.append(calendar.date(byAdding: .day, value: i, to: startOfCurrentWeek!)!)
        }
        
        return weekDates[atIndex]
    }
    
    private func getName(atIndex: Int) -> String {
        
        let shortWeekDaysEU = ["Mo","Tu","We","Th","Fr","Sa","Su"]
        let shortWeekDaysUS = ["Su","Mo","Tu","We","Th","Fr","Sa"]
        
        if calendar.firstWeekday == 1 {
            // Sunday is first weekday
            return shortWeekDaysUS[atIndex]
        } else {
            return shortWeekDaysEU[atIndex]
        }
    }
    
    private func getStringDate(atIndex: Int) -> String {
        
        let date = getDate(atIndex: atIndex)
        
        // formats dates to double diget format (03,04,..)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        
        return dateFormatter.string(from: date)
    }
    
    private func getWorkout(atIndex: Int) -> Bool {
        
        var done = false
        
        let lastWorkouts = workouts.savedWorkouts
        
        let currentDate = getDate(atIndex: atIndex)
        
        for ( _ , value) in lastWorkouts.enumerated() {
            if (value.date.formatted(date: .abbreviated, time: .omitted) == currentDate.formatted(date: .abbreviated, time: .omitted)) {
                done = true
                break
            }
        }
        
        return done
    }
}
