//
//  User.swift
//  Fitness App
//

import Foundation
import SwiftUI

class UserObject: ObservableObject {
    
    // Height in CM
    @AppStorage("height") var height = 0
    
    // Age in year
    @AppStorage("age") var age = 1996
    
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

/*
 Is a Environment Object. It should be called like this:
 
 // User Info
 @EnvironmentObject var user: UserObject
 
 Don't make a new instance of it
 */
