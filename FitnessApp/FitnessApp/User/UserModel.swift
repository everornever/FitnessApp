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
    
    // Goal
    var weeklyGoal: Int = 0
    
    // App Version
    var firstStart: Bool = true
    var lastVersion: String = "0.0.6"
    
    // Saved Workouts
    var workouts: [Workout] = []
    
    //Saved Weight
    var weightEntries: [WeightEntry] = []
    
    // Saved Exercises
    var exerciseNotes: [ExerciseNote] = [ExerciseNote(name: "Bench Press", kilos: 20.0),ExerciseNote(name: "Deadlift", kilos: 20.0), ExerciseNote(name: "Squats", kilos: 20.0)]
    
}

struct Workout: Identifiable, Codable {
    var id = UUID()
    let exercises: Int
    let date: Date
    let duration: TimeInterval
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
