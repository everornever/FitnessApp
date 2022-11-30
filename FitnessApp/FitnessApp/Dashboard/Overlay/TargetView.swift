//
//  TargetView.swift
//  Fitness App
//

import SwiftUI

struct TargetView: View {
    
    // User Info
    @ObservedObject var user = User()
    
    // Current Week Workouts
    let week = CurrentWeek().getCurrentWeek()
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Text("Weekly Target")
                        .font(.title)
                    
                    Spacer()
                    
                    Text("\(checkCurrentTarget()) / \(user.target)")
                        .font(.title)
                        .bold()
                }
                Rectangle()
                    .frame(height: 150)
                    .foregroundColor(Color.DS_Primary_RV)
            }
            .padding()
            .background(Color.DS_Overlay)
            .cornerRadius(20)
            .padding(.top)
            
            
            Stepper("How often do you want to train per week?",value: $user.target,  in: 1...7)
                .padding()
                .background(Color.DS_Background)
                .cornerRadius(20)
            
            
            Spacer()
        }
        
    }
    
    func checkCurrentTarget() -> Int {
        var workoutsDone = 0
        for ( _ , value) in week.enumerated() {
            if (value.workoutDone) {
                workoutsDone += 1
            }
        }
        return workoutsDone
    }
}

struct TargetView_Previews: PreviewProvider {
    static var previews: some View {
        TargetView()
    }
}
