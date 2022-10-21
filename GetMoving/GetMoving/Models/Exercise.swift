//
//  Exercise.swift
//  GetMoving
//
//  Created by Leon Kling on 20.10.22.
//

import Foundation

struct Exercise: Identifiable, Codable {
    var id = UUID()
    var name: String
    var kilo: Double
}

class SavedExercises: ObservableObject {
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
        savedExercises = [Exercise(name: "Bankdrücken", kilo: 20.0),Exercise(name: "Kreuzheben", kilo: 20.0), Exercise(name: "Squats", kilo: 20.0)]
    }
}
