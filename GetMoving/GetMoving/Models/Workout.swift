//
//  Workout.swift
//  GetMoving
//
//  Created by Leon Kling on 30.08.22.
//

import Foundation

// Workout defines the propertys of one workout instance
// Codable for the JASON encoder, Identifiable for the UUID Property
struct Workout: Identifiable, Codable {
    var id = UUID()
    let exercises: Int
    let date: Date
    let duration: TimeInterval
}

// Saved Workouts makes an array of Workouts with a UserDefault Get/Set attached
// @puplish will anounce changes
class SavedWorkouts: ObservableObject {
    @Published var workoutArray = [Workout]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(workoutArray) {
                UserDefaults.standard.set(encoded, forKey: "WorkoutArray")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "WorkoutArray") {
            if let decodedItems = try? JSONDecoder().decode([Workout].self, from: savedItems) {
                workoutArray = decodedItems
                return
            }
        }
        workoutArray = []
    }
}
