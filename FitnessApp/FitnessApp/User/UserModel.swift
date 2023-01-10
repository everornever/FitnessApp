//
//  UserModel.swift
//  Fitness App
//

import Foundation

struct User: Identifiable, Codable {
    
    var id = UUID()
    
    // User metrics
    var height: Int = 170
    var age: Int = 1996
    
    // Workout settings
    var restTimer: Double = 90.0
    var restTimerSound: String = "Bell-One"
    var includeWarmup: Bool = true
    var includeStretching: Bool = false
    var disabledSleep: Bool = false
    
    // Goal
    var weeklyGoal: Int = 0
    
    // App Version
    var firstStart: Bool = true
    var lastVersion: String = "0.0.6"
    
    // Saved Workouts
    var workouts: [Workout] = []
    
    //Saved Weight
    var weightEntries: [WeightEntry] = []
    
    // Muscle Tags
    var tags: [Tag] = [Tag(name: "Chest", icon: "questionmark.circle.fill"),
                       Tag(name: "Legs", icon: "questionmark.circle.fill"),
                       Tag(name: "Arms", icon: "questionmark.circle.fill"),
                       Tag(name: "Bicep", icon: "questionmark.circle.fill"),
                       Tag(name: "Tricep", icon: "questionmark.circle.fill"),
                       Tag(name: "Shoulders", icon: "questionmark.circle.fill"),
                       Tag(name: "Back", icon: "questionmark.circle.fill"),
                       Tag(name: "Gluts", icon: "questionmark.circle.fill"),
                       Tag(name: "Core", icon: "questionmark.circle.fill"),
                       Tag(name: "Push", icon: "questionmark.circle.fill"),
                       Tag(name: "Pull", icon: "questionmark.circle.fill"),]
    
    // Saved Exercises
    var exerciseNotes: [ExerciseNote] = [ExerciseNote(name: "Bench Press", kilos: 20.0),ExerciseNote(name: "Deadlift", kilos: 20.0), ExerciseNote(name: "Squats", kilos: 20.0)]
    
}

struct Workout: Identifiable, Codable {
    var id = UUID()
    let exercises: Int
    let date: Date
    let duration: TimeInterval
    let stretchingDone: Bool
    let warmupDone: Bool
    var tags: [Tag] = []
}

struct Tag: Identifiable, Codable {
    var id = UUID()
    let name: String
    let icon: String
}

struct WeightEntry: Identifiable, Codable {
    var id = UUID()
    let weight: Double
    let date: Date
}

struct ExerciseNote: Identifiable, Codable {
    var id = UUID()
    var name: String
    var kilos: Double
}
