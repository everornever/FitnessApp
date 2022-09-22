//
//  WeekView.swift
//  GetMoving
//
//  Created by Leon Kling on 08.09.22.
//

import SwiftUI

struct CurrentWeekDay: Identifiable {
    let id = UUID()
    let name: String
    let date: Date
    let done: Bool
}

struct WeekView: View {
    
    @EnvironmentObject var savedWorkouts: SavedWorkouts
    
    let currentWeek: [CurrentWeekDay]
    
    var body: some View {
        HStack(spacing: 10) {
            ForEach(days) { days in
                if(days.done) {
                    VStack {
                        Text(days.date.formatted.("EEEE"))
                            .font(.caption)
                            .padding(.bottom)
                        
                        Text(days.name)
                            .font(.caption2)
                    }
                    .frame(width: 40, height: 80)
                    .background(.green.opacity(0.1))
                    .cornerRadius(40)
                } else {
                    VStack {
                        Text(days.date)
                            .font(.caption)
                            .padding(.bottom)
                        
                        Text(days.name)
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
    }
    
    func CreateWeek() {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        
        let calendar = Calendar.current
        let dayOfWeek = calendar.firstWeekday
        let days = calendar.range(of: .weekday, in: .weekOfYear, for: dayOfWeek)!
            .compactMap { calendar.date(byAdding: .day, value: $0 - dayOfWeek, to: dayOfWeek) }
            .filter { !calendar.isDateInWeekend($0) }
        
        
    }
    
    func CheckInCurrentWeek() {
        ForEach(days) { weekDays in
            if (savedWorkouts.workoutArray.contains(where: {$0.date == Date.now})) {
                
            }
        }
    }
    
}

struct WeekView_Previews: PreviewProvider {
    static var previews: some View {
        WeekView()
    }
}
