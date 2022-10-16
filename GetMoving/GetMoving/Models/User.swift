//
//  User.swift
//  GetMoving
//
//  Created by Leon Kling on 16.09.22.
//

import Foundation
import SwiftUI

class User: ObservableObject {
    @AppStorage("name") var name = ""
    @AppStorage("pauseTimer") var pauseTimer = 90.0
}
