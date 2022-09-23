//
//  CurrentWeek.swift
//  GetMoving
//
//  Created by Leon Kling on 23.09.22.
//

import Foundation

class CurrentWeek {

    private let date = Date()
    private let calendar = Calendar.current
    
    func getCurrentNames() -> [String] {
        return calendar.shortWeekdaySymbols
    }
    
    func getcurrentDates() -> [Date] {
        
        // gets the date from last Sunday
         let lastSunday = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date))

        // will add one day to last Sunday to get current Monday
         let thisMonday = calendar.date(byAdding: .day, value: 1, to: lastSunday!)

        // will get the upcomming Sunday this week
        // let thisSunday = calendar.date(byAdding: .day, value: 7, to: lastSunday!)

        // check this array for workout dates?
        // maps out every day starting Monday with its date until next Sunday
         let dates = calendar.range(of: .weekday, in: .weekOfYear, for: thisMonday!)!
            .compactMap { calendar.date(byAdding: .day, value: $0, to: lastSunday!) }
        
        return dates
    }
    
    func getStringDates() -> [String] {
        
        // gets the date from last Sunday
         let lastSunday = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date))

        // will add one day to last Sunday to get current Monday
         let thisMonday = calendar.date(byAdding: .day, value: 1, to: lastSunday!)

        // check this array for workout dates?
        // maps out every day starting Monday with its date until next Sunday
         let dates = calendar.range(of: .weekday, in: .weekOfYear, for: thisMonday!)!
            .compactMap { calendar.date(byAdding: .day, value: $0, to: lastSunday!) }

        // formats dates to double diget format
         let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"

        // array with all weekday dates as string
        var weekdays = [String]()
        for i in dates.indices {
            weekdays.append(dateFormatter.string(from: dates[i]))
        }
        
        return weekdays
    }
    
    func CheckDateInCurrentWeek(paasedDate: Date) -> Bool {
        
        // gets the date from last Sunday
         let lastSunday = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date))

        // will add one day to last Sunday to get current Monday
         let thisMonday = calendar.date(byAdding: .day, value: 1, to: lastSunday!)

        // will get the upcomming Sunday this week
        // let thisSunday = calendar.date(byAdding: .day, value: 7, to: lastSunday!)

        // check this array for workout dates?
        // maps out every day starting Monday with its date until next Sunday
         let dates = calendar.range(of: .weekday, in: .weekOfYear, for: thisMonday!)!
            .compactMap { calendar.date(byAdding: .day, value: $0, to: lastSunday!) }
        
        var dateWasWorked = false
        
        for i in dates {
            if calendar.isDate(paasedDate, equalTo: i, toGranularity: .day) {
                dateWasWorked = true
            }
        }
        
        return dateWasWorked

    }
    
}
