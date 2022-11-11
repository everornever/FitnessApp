//
//  User.swift
//  GetMoving
//
//  Created by Leon Kling on 16.09.22.
//

import Foundation
import SwiftUI

class User: ObservableObject {
    
    // User Metric
    @AppStorage("weight") var weight = 0.0
    @AppStorage("weight") var height = 0.0
    @AppStorage("weight") var age = 0
    
    // Workout Settings
    @AppStorage("pauseTimer") var pauseTimer = 90.0
    @AppStorage("includeWormup") var includeWormup = false
    @AppStorage("includeStreching") var includeStreching = false
    
    // Streak
    @AppStorage("target") var target = 0
    
    // App Version
    @AppStorage("firstStart") var firstStart = true
    @AppStorage("lastVersion") var lastVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
    
    

}
