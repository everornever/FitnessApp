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
}
