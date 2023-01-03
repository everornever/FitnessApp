//
//  Fitness_WidgetBundle.swift
//  Fitness Widget
//
//  Created by Leon Kling on 01.01.23.
//

import WidgetKit
import SwiftUI

@main
struct Fitness_WidgetBundle: WidgetBundle {
    var body: some Widget {
        ProgressWidget()
        Fitness_WidgetLiveActivity()
    }
}
