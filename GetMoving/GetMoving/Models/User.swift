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
    @AppStorage("name") var name = ""
    @AppStorage("weight") var weight = 70.0
    
    // Workout Settings
    @AppStorage("pauseTimer") var pauseTimer = 90.0
    @AppStorage("includeWormup") var includeWormup = false
    @AppStorage("includeStreching") var includeStreching = false
    
    // Streak
    @AppStorage("target") var target = 1
    
    

}
