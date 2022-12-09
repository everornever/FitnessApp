//
//  User.swift
//  Fitness App
//

import Foundation
import SwiftUI

class User: ObservableObject {
    
    // User Metric
    @AppStorage("weight") var weight = 0.0
    @AppStorage("height") var height = 0
    @AppStorage("age") var age = 0
    
    // Workout Settings
    @AppStorage("pauseTimer") var pauseTimer = 90.0
    @AppStorage("pauseTimerSound") var pauseTimerSound = "Bell-One"
    @AppStorage("includeWarmup") var includeWarmup = true
    @AppStorage("includeStretching") var includeStretching = false
    
    // Streak
    @AppStorage("target") var target = 0
    
    // App Version
    @AppStorage("firstStart") var firstStart = true
    @AppStorage("lastVersion") var lastVersion = "0.0.6"
}
