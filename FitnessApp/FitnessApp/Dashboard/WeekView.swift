//
//  WeekView.swift
//  Fitness App
//

import SwiftUI

struct WeekView: View {
    
    // User Info
    @EnvironmentObject var userObject: UserObject
    
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
                    .foregroundColor(week[index].workoutDone ? Color.black : Color.primary)
                    .background(week[index].workoutDone ? Color.SingleAccent : Color.Layer2)
                    .cornerRadius(40)
                    
                    if(Calendar.current.isDateInToday(week[index].date)) {
                        Rectangle()
                            .frame(width: 10, height: 10)
                            .cornerRadius(20)
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
            .environmentObject(UserObject())
    }
}
