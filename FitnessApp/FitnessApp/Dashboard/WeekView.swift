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
        HStack(alignment: .top) {
            ForEach(0..<7) { index in
                VStack {
                    VStack {
                        Text(week[index].stringDate)
                            .font(.caption)
                            .padding(.bottom)
                        
                        Text(week[index].dayName)
                            .font(.caption2)
                    }
                    .frame(width: 40, height: 80)
                    .foregroundColor(week[index].workoutDone ? Color.black : Color.DS_Primary)
                    .background(week[index].workoutDone ? Color.DS_Accent : Color.DS_Primary_RV)
                    .cornerRadius(40)
                    
                    if(Calendar.current.isDateInToday(week[index].date)) {
                        Rectangle()
                            .frame(width: 10, height: 10)
                            .cornerRadius(20)
                        .padding(.bottom)
                    }
                }
                
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
