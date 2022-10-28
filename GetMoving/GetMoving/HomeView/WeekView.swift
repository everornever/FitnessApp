//
//  WeekView.swift
//  GetMoving
//
//  Created by Leon Kling on 08.09.22.
//

import SwiftUI

struct WeekView: View {
    
    let dayNames = CurrentWeek().getCurrentNames()
    let dayDates = CurrentWeek().getStringDates()
    let workoutDone = CurrentWeek().getworkoutdays()
    
    var body: some View {
        HStack {
            ForEach(0..<7) { index in
                VStack {
                    Text(dayDates[index])
                        .font(.caption)
                        .padding(.bottom)
                    
                    Text(dayNames[index])
                        .font(.caption2)
                }
                .frame(width: 40, height: 80)
                .background(workoutDone[index] ? Color("FirstColor") : Color.secondary.opacity(0.1))
                .cornerRadius(40)
                
                if (index < 6) {
                    Spacer()
                }
                
            }
        }
        .monospacedDigit()
        .lineLimit(1)
        
    }
}

// MARK: - Preview
struct WeekView_Previews: PreviewProvider {
    static var previews: some View {
        WeekView()
    }
}
