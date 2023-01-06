//
//  User.swift
//  Fitness App
//

import Foundation
import SwiftUI

class UserObject: ObservableObject {
    
    @Published var props = User() {
        didSet {
            if let encoded = try? JSONEncoder().encode(props) {
                UserDefaults.appGroup.set(encoded, forKey: UserDefaults.Keys.SavedUser.rawValue)
            }
        }
    }
    
    init() {
        if let savedItem = UserDefaults.appGroup.data(forKey: UserDefaults.Keys.SavedUser.rawValue) {
            if let decodedUser = try? JSONDecoder().decode(User.self, from: savedItem) {
                props = decodedUser
                return
            }
        }
        props = User()
    }
    
    // MARK: - Functions:
    
    // Returns amount of every workout done on the given week number
    func getCurrentWorkoutAmount(weekNumber: Int) -> Int {
        var tempArray = [Workout]()
        for index in props.workouts {
            if (Calendar.current.component(.weekOfYear, from: index.date) == weekNumber) {
                tempArray.append(index)
            }
        }
        return tempArray.count
    }
    
    // Save Weight Entry
    func saveWeightEntry(value: Double) {
        props.weightEntries.append(WeightEntry(weight: value, date: Date.now))
    }
    
    
    
    
    
}

/*
 Is a Environment Object. It should be called like this:
 
 // User Info
 @EnvironmentObject var userObject: UserObject
 
 Don't make a new instance of it
 */

//struct WeekNumber: Identifiable {
//    var id = UUID()
//    let weekNumber: Int
//    let workouts: [Workout]
//}
