//
//  WeekView.swift
//  GetMoving
//
//  Created by Leon Kling on 08.09.22.
//

import SwiftUI

struct WeekView: View {
    
    @EnvironmentObject var savedWorkouts: SavedWorkouts
    
    let weekDates = CurrentWeek().getcurrentDates()
    let weekNumbers = CurrentWeek().getStringDates()
    let dayNames = CurrentWeek().getCurrentNames()
    
    
    var body: some View {
        HStack(spacing: 10) {
            ForEach(0..<7) { index in
                if(temp(index: index)) {
                    VStack {
                        Text(weekNumbers[index])
                            .font(.caption)
                            .padding(.bottom)
                        
                        Text(dayNames[index])
                            .font(.caption2)
                    }
                    .frame(width: 40, height: 80)
                    .background(.green.opacity(0.1))
                    .cornerRadius(40)
                }
                else {
                    VStack {
                        Text(weekNumbers[index])
                            .font(.caption)
                            .padding(.bottom)
                        
                        Text(dayNames[index])
                            .font(.caption2)
                    }
                    .frame(width: 40, height: 80)
                    .background(.regularMaterial)
                    .cornerRadius(40)
                }
                
            }
        }
        .monospacedDigit()
        .lineLimit(1)
        .padding()
        
    } // end Of Body
    
    func temp(index: Int) -> Bool {
        let tempi = savedWorkouts.workoutArray.suffix(7)
        var nooo = false
        
        for i in tempi {
            if CurrentWeek().CheckDateInCurrentWeek(paasedDate: i.date) {
                nooo = true
            }
        }
        
        return nooo
        
        
    }
    
} // end of View


struct WeekView_Previews: PreviewProvider {
    
    static let myEnvObject = SavedWorkouts()
    
    static var previews: some View {
        WeekView()
            .environmentObject(myEnvObject)
    }
}
