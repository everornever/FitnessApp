//
//  WeekView.swift
//  GetMoving
//
//  Created by Leon Kling on 08.09.22.
//

import SwiftUI

struct WeekView: View {
    
    let week = CurrentWeek().getCurrentWeek()
    
    var body: some View {
        HStack {
            ForEach(0..<7) { index in
                VStack {
                    Text(week[index].stringDate)
                        .font(.caption)
                        .padding(.bottom)
                    
                    Text(week[index].dayName)
                        .font(.caption2)
                }
                .frame(width: 40, height: 80)
                .background(week[index].workoutDone ? Color("FirstColor") : Color.secondary.opacity(0.1))
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
