//
//  CurrentWeekView.swift
//  Fitness WidgetExtension
//

import SwiftUI
import WidgetKit

struct CurrentWeekView: View {
    
    let calendar = Calendar.current
    
    let userObject: User
    
    var body: some View {
        ZStack {
            
            ContainerRelativeShape().fill(Color.DSOverlay)
            
            VStack {
                
                HStack {
                    Text("Weekly Goal")
                    Spacer()
                    Text("\(getWorkoutsDoneAmount()) / \(userObject.weeklyGoal)")
                    
                }
                .font(.subheadline)
                .bold()
                .padding(.bottom, 10)
                
                HStack(alignment: .top) {
                    ForEach(0..<7, id: \.self) { index in
                        VStack {
                            VStack {
                                Text("\(getCurrentWeek()[index].stringDate)")
                                    .font(.caption)
                                    .padding(.bottom, 10)
                                
                                Text("\(getCurrentWeek()[index].dayName)")
                                    .font(.caption)
                            }
                            .monospacedDigit()
                            .frame(width: 35, height: 75)
                            .foregroundColor(getCurrentWeek()[index].workoutDone ? Color.black : Color.DSPrimary)
                            .background(getCurrentWeek()[index].workoutDone ? Color.DSAccent : Color.DSPrimary_RV)
                            .cornerRadius(40)
                            
                            if (Calendar.current.isDateInToday(getCurrentWeek()[index].date)) {
                                Circle().frame(width: 8, height: 8)
                            }
                        }
                    }
                }
            }
            .padding(.horizontal, 25)
        }
    }
    
    private func getCurrentWeek() -> [Day] {
        
        var week = [Day]()
        
        for index in 0..<7 {
            week.append(Day(date: getDate(atIndex: index),stringDate: getStringDate(atIndex: index), dayName: getName(atIndex: index), workoutDone: getWorkout(atIndex: index)))
        }
        
        return week
    }
    
    // get current target amount
    private func getWorkoutsDoneAmount() -> Int {
        
        let week = getCurrentWeek()
        var amount = 0
        
        for index in week {
            if (index.workoutDone == true) {
                amount += 1
            }
        }
        return amount
    }
    
    private func getDate(atIndex: Int) -> Date {
        
        let startOfCurrentWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date()))
        
        var weekDates: [Date] = []
        
        for i in 0..<7 {
            weekDates.append(calendar.date(byAdding: .day, value: i, to: startOfCurrentWeek!)!)
        }
        
        return weekDates[atIndex]
    }
    
    private func getName(atIndex: Int) -> String {
        
        let shortWeekDaysEU = ["Mo","Tu","We","Th","Fr","Sa","Su"]
        let shortWeekDaysUS = ["Su","Mo","Tu","We","Th","Fr","Sa"]
        
        if calendar.firstWeekday == 1 {
            // Sunday is first weekday
            return shortWeekDaysUS[atIndex]
        } else {
            return shortWeekDaysEU[atIndex]
        }
    }
    
    private func getStringDate(atIndex: Int) -> String {
        
        let date = getDate(atIndex: atIndex)
        
        // formats dates to double diget format (03,04,..)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        
        return dateFormatter.string(from: date)
    }
    
    private func getWorkout(atIndex: Int) -> Bool {
        
        var done = false
        
        let currentDate = getDate(atIndex: atIndex)
        
        for ( _ , value) in userObject.workouts.enumerated() {
            if (value.date.formatted(date: .abbreviated, time: .omitted) == currentDate.formatted(date: .abbreviated, time: .omitted)) {
                done = true
                break
            }
        }
        
        return done
    }
}

struct CurrentWeekView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentWeekView(userObject: User())
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
