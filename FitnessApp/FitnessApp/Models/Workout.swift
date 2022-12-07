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
    // TODO: What is for Workouts next year same weeknumber?
    func sortedAfterWeeks() -> Array<WeekNumber> {
        var weeks = [WeekNumber]()
        
        for index in workoutArray {
            if (weeks.contains { $0.weekNumber == index.date.getWeekNumber() } ) {
                // ignore
            } else {
                weeks.append(WeekNumber(weekNumber: index.date.getWeekNumber(), workouts: giveBackArray(number: index.date.getWeekNumber())))
            }
        }
        return weeks
    }
    
    private func giveBackArray(number: Int) -> Array<Workout> {
        var tempArray = [Workout]()
        
        for index in workoutArray {
            if (index.date.getWeekNumber() == number) {
                tempArray.append(index)
            }
        }
        return tempArray
    }
    
}
