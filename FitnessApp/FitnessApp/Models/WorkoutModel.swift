//
//  WorkoutModel.swift
//  Fitness App
//

import Foundation

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
