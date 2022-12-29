//
//  Exercise.swift
//  Fitness App
//

import Foundation

struct Exercise: Identifiable, Codable {
    var id = UUID()
    var name: String
    var kilo: Double
}

class ExerciseObject: ObservableObject {
    @Published var savedExercises = [Exercise]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(savedExercises) {
                UserDefaults.standard.set(encoded, forKey: "SavedExercises")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "SavedExercises") {
            if let decodedItems = try? JSONDecoder().decode([Exercise].self, from: savedItems) {
                savedExercises = decodedItems
                return
            }
        }
        savedExercises = [Exercise(name: "Bench Press", kilo: 20.0),Exercise(name: "Deadlift", kilo: 20.0), Exercise(name: "Squats", kilo: 20.0)]
    }
}

/*
 This is NO Environment Object! It should be called like this:
 
 // Exercise Object
 @ObservedObject var exerciseObject = ExerciseObject()
 
 */
