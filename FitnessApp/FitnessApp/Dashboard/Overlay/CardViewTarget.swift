//
//  CardViewTarget.swift
//  Fitness App
//

import SwiftUI

struct CardViewTarget: View {
    
    let userInput: Int
    
    let week = CurrentWeek().getCurrentWeek()
    
    var body: some View {
        VStack {
            
            
            VStack(alignment: .trailing) {
                Text("\(checkCurrentTarget()) / \(userInput)")
                    .font(.title3)
                    .bold()
                
                Text("Target")
                    .foregroundColor(Color.DS_Light)
                    .font(.subheadline)
            }
            
            .padding([.leading,.trailing,.top])
            
            VStack {
                HStack {
                    ForEach(0..<6) { week in
                        VStack {
                            ZStack(alignment: .bottom) {
                                RoundedRectangle(cornerRadius: 20)
                                    .foregroundColor(Color.DS_Overlay)
                                    .frame(width: 6)
                                
                                if (week == 5) {
                                    RoundedRectangle(cornerRadius: 20)
                                        .foregroundColor(Color.DS_Accent)
                                        .frame(width: 6, height: 20)
                                }
                            }
                            
                            if (week == 0) {
                                Text("52")
                                    .foregroundColor(.DS_Light)
                                    .monospacedDigit()
                                    .font(.caption2)
                            }
                            else if (week == 5) {
                                Text("57")
                                    .foregroundColor(.DS_Light)
                                    .monospacedDigit()
                                    .font(.caption2)
                            }
                            else {
                                Text("52")
                                    .font(.caption2)
                                    .monospacedDigit()
                                    .hidden()
                            }
                        }
                    }
                }
            }
            .padding([.leading,.trailing])
            .padding(.bottom, 10)
        }
        .frame(maxWidth: .infinity ,maxHeight: .infinity)
        .background(Color.DS_Background)
        .cornerRadius(10)
        
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

struct CardViewTarget_Previews: PreviewProvider {
    static var previews: some View {
        CardViewTarget(userInput: 4)
    }
}
