//
//  Workout.swift
//  Fitness App
//

import Foundation
import WidgetKit

class WorkoutObject: ObservableObject {
    @Published var savedWorkouts = [Workout]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(savedWorkouts) {
                // Make sure to use your "App Group" container suite name when saving and retrieving the object from UserDefaults
                UserDefaults(suiteName: "group.BETA-CODE.FitnessApp")!.set(encoded, forKey: "SavedWorkouts")
                
                // Used to get the widget extension to reload the timeline
                WidgetCenter.shared.reloadAllTimelines()
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults(suiteName: "group.BETA-CODE.FitnessApp")!.data(forKey: "SavedWorkouts") {
            if let decodedItems = try? JSONDecoder().decode([Workout].self, from: savedItems) {
                savedWorkouts = decodedItems
                return
            }
        }
        savedWorkouts = []
    }
    
    // MARK: - Functions:
    
    // Get last 6 week Numbers as Strings
    func getLastSixWeeks() -> Array<Int> {
        var weeks = [Int]()
        let currentWeek = Date.now.getWeekNumber()
        
        for index in 0...5 {
            weeks.append(currentWeek - index)
        }
        
        return weeks.reversed()
    }
    
    // returns amount of every workout done on the given week number
    // TODO: two workouts on same day are counted ??
    func getWorkoutAmount(number: Int) -> Int {
        var tempArray = [Workout]()
        
        for index in savedWorkouts {
            if (index.date.getWeekNumber() == number) {
                tempArray.append(index)
            }
        }
        
        return tempArray.count
    }
    
}

/*
 Is a Environment Object. It should be called like this:
 
 // Saved Workouts
 @EnvironmentObject var workouts: SavedWorkouts
 
 Don't make a new instance of it
 */
