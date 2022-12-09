//
//  Workout.swift
//  Fitness App
//

import Foundation

// Codable for the JASON encoder, Identifiable for the UUID Property
struct Workout: Identifiable, Codable {
    var id = UUID()
    let exercises: Int
    let date: Date
    let duration: TimeInterval
    
}

struct WeekNumber: Identifiable {
    var id = UUID()
    let weekNumber: Int
    let workouts: [Workout]
}

// Saved Workouts makes an array of Workouts with a UserDefault Get/Set attached
class SavedWorkouts: ObservableObject {
    @Published var workoutArray = [Workout]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(workoutArray) {
                UserDefaults.standard.set(encoded, forKey: "SavedWorkouts")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "SavedWorkouts") {
            if let decodedItems = try? JSONDecoder().decode([Workout].self, from: savedItems) {
                workoutArray = decodedItems
                return
            }
        }
        workoutArray = []
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
        
        for index in workoutArray {
            if (index.date.getWeekNumber() == number) {
                tempArray.append(index)
            }
        }
        
        return tempArray.count
    }
    
}
