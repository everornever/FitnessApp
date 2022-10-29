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
    let name: String
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
        
        var week: [Day]
        
        for index in 0...6 {
            week.append(Day(date: getDate(atIndex: index), name: getName(atIndex: index), workoutDone: getworkout(atIndex: index)))
        }
        
        return week
    }
    
    
    private func getDate(atIndex: Int) -> Date {
        
        print("Get Dates Methode:")
        
        // Initial Values
        let lastSunday = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date))!
        let thisMonday = calendar.date(byAdding: .day, value: 1, to: lastSunday)!
        let thisSunday = calendar.date(byAdding: .day, value: 7, to: lastSunday)!
        
        print("lastSunday:", lastSunday)
        print("thisMonday:", thisMonday)
        print("thisSunday:", thisSunday)
        
        /// maps out every day starting Monday with its date until next Sunday
        let dates = calendar.range(of: .weekday, in: .weekOfYear, for: thisMonday)!.compactMap { calendar.date(byAdding: .day, value: $0, to: thisMonday) }
        print("Date Array:", dates)
        
        // TODO: enum case for index, give out date for index
        
        return dates[atIndex]
    }
    
    
    
    
    
    
    /// - Description: sets start and end day for current week
    /// - Returns: (2022-09-25 22:00:00 +0000, 2022-09-28 22:00:00 +0000)
    private func setWeekParameter() -> (Date?, Date?) {
        
        let lastSunday = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date)) ?? Date()
        
        // will add one day to last Sunday to get current Monday
        let thisMonday = calendar.date(byAdding: .day, value: 1, to: lastSunday) ?? Date()
        
        // will get the upcomming Sunday this week
//         let thisSunday = calendar.date(byAdding: .day, value: 7, to: lastSunday!)
        
        return (lastSunday, thisMonday)
    }
    
    /// - Description: returns array with every current week day with date and time
    /// - Returns: [2022-09-26 22:00:00, 2022-09-27 22:00:00, ... ]
    private func getcurrentDates() -> [Date] {
        
        let lastSunday = setWeekParameter().0
        let Monday = setWeekParameter().1
        
        // maps out every day starting Monday with its date until next Sunday
        let dates = calendar.range(of: .weekday, in: .weekOfYear, for: Monday!)!
            .compactMap { calendar.date(byAdding: .day, value: $0, to: lastSunday!) }
        
        return dates
    }
    
    
    // MARK: - Puplic Functions
    
    
    /// - Description: Array of Strings with short Week Names from current calender / or hard coded
    /// - Returns: ["Mo","Di",...]
    func getCurrentNames() -> [String] {
//        calendar.locale = NSLocale(localeIdentifier: "de_DE") as Locale
//        return calendar.shortWeekdaySymbols
        let shortWeekDays = ["Mo","Di","Mi","Do","Fr","Sa","So"]
        return shortWeekDays
    }
    
    /// - Description: Array with short day date as a string
    /// - Returns: ["03","04",...]
    func getStringDates() -> [String] {
        
        let dates = getcurrentDates()
        
        // formats dates to double diget format (03,04,..)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        
        // array with all weekday dates as string
        var weekdays = [String]()
        for i in dates.indices {
            weekdays.append(dateFormatter.string(from: dates[i]))
        }
        
        return weekdays
    }
    
    /// - Description: checks if passed in date is in current week
    /// - Returns: Bool
    func CheckDateInCurrentWeek(paasedDate: Date) -> Bool {
        
        let firstDay = setWeekParameter().0!
        let lastDay = setWeekParameter().1!
        
        let range = firstDay...lastDay
        
        if range.contains(paasedDate) {
            return true
        } else {
            return false
        }
    }
    
    func getworkoutdays() -> [Bool] {
        
        let dates = getcurrentDates()
        
        let lastworkouts = savedWorkouts.workoutArray.suffix(14)
        
        print(lastworkouts)
        
        let filtered = lastworkouts.filter { workout in
            return workout.date > setWeekParameter().0!
        }
        
        print(filtered)
        
        
        
        
        
        return [false,false,false,false,true,true,false]
    }
    
}
