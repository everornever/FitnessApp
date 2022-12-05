//
//  TargetView.swift
//  Fitness App
//

import SwiftUI
import Charts

struct TargetView: View {
    
    // User Info
    @ObservedObject var user = User()
    
    // Saved Workouts
    @EnvironmentObject var savedWorkouts: SavedWorkouts
    
    // Current Week Workouts
    let week = CurrentWeek().getCurrentWeek()
    
    // Dismiss Button
    @Environment(\.dismiss) var dismiss
    
    // Calender
    let calendar = Calendar.current
    
    var body: some View {
        VStack {
            HStack { // Top
                Text("Weekly Target")
                    .font(.title)
                    .bold()
                Spacer()
                Button { dismiss() } label: {
                    XLable(tint: Color.DS_Primary, back: Color.DSBackground)
                }
            }
            .padding(.top)
            
            VStack(alignment: .leading) {
                Text("Your workouts in the last 6 Weeks")
                    .font(.caption2)
                    .foregroundColor(Color.DS_Light)
                    .padding(.top)
                
                Chart(savedWorkouts.sortedAfterWeeks()) { shape in
                    
                    RuleMark(y: .value("Goal", user.target))
                        .foregroundStyle(Color.DS_SecondAccent)
                        .lineStyle(StrokeStyle(lineWidth: 4, dash: [8]))
                        .annotation(alignment: .leading) {
                            Text("Target")
                                .font(.caption2)
                                .foregroundColor(Color.DS_Light)
                        }
                    
                    BarMark(
                        x: .value("Calender Week", shape.weekNumber),
                        y: .value("Amount of Workouts", shape.workouts.count)
                    )
                    .foregroundStyle(Color.DS_Accent)
                    
                }
                .chartXAxisLabel() {
                    Text("Calender Week")
                }
                .chartXScale(domain: getWeekNumberValues().lastSixWeeks...getWeekNumberValues().currentWeek)
//                .chartXAxis {
//                    AxisMarks(values: getWeekNumberValues().lastArray) { _ in
//                        AxisGridLine()
//                        AxisValueLabel(centered: true)
//                    }
//                }

                .frame(height: 300)
            }
            .padding()
            .background(Color.DSBackground)
            .cornerRadius(20)
            
            HStack { // Weekly Target
                VStack(alignment: .leading) {
                    Text("Weekly Target")
                        .font(.subheadline)
                        .foregroundColor(.DS_Light)
                    Text("\(user.target)")
                        .font(.title2)
                        .bold()
                }
                Spacer()
                HStack {
                    Button("-") { subtracTarget() }
                        .buttonStyle(.borderedProminent)
                        .tint(Color.DS_Primary)
                        .foregroundColor(Color.DS_Primary_RV)
                    Button("+") { addTarget() }
                        .buttonStyle(.borderedProminent)
                        .tint(Color.DS_Primary)
                        .foregroundColor(Color.DS_Primary_RV)
                }
            }
            .padding()
            .background(Color.DSBackground)
            .cornerRadius(10)
            
            HStack {
                HStack { // Total Workouts
                    VStack(alignment: .leading) {
                        Text("Total workouts")
                            .font(.subheadline)
                            .foregroundColor(.DS_Light)
                        Text("\(savedWorkouts.workoutArray.count)")
                            .font(.title2)
                            .bold()
                    }
                    Spacer()
                }
                .padding()
                .background(Color.DSBackground)
                .cornerRadius(10)
                
                HStack { // Longest Workout
                    VStack(alignment: .leading) {
                        Text("Longest Workout")
                            .font(.subheadline)
                            .foregroundColor(.DS_Light)
                        Text(longestWorkout())
                            .font(.title2)
                            .bold()
                    }
                    Spacer()
                }
                .padding()
                .background(Color.DSBackground)
                .cornerRadius(10)
            }
            
            
            Spacer()
        }
        .padding()
        
        
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
    
    func addTarget() {
        if (user.target < 7) {
            user.target += 1
        }
    }
    
    func subtracTarget() {
        if (user.target > 1) {
            user.target -= 1
        }
    }
    
    func longestWorkout() -> String {
        let max = savedWorkouts.workoutArray.map { $0.duration }.max()
        
        return max?.timeString().hours ?? "00:00"
    }
    
    func getWeekNumberValues() -> (lastSixWeeks: Int, currentWeek: Int, lastArray: [Int]) {
        
        // Current week number minus 6 weeks
        let lastSixWeeks = (savedWorkouts.sortedAfterWeeks().last?.weekNumber ?? 7) - 6
        
        // Array of last
        let lastArry = savedWorkouts.sortedAfterWeeks().map { $0.weekNumber }
        
        // Current week number + 1 for fornt puffer
        let currentWeek = (savedWorkouts.sortedAfterWeeks().last?.weekNumber ?? 51) + 1
        
        return (lastSixWeeks, currentWeek, lastArry)
    }
}

struct TargetView_Previews: PreviewProvider {
    
    static let previewObject = SavedWorkouts()
    
    static var previews: some View {
        
        TargetView().environmentObject(previewObject)
    }
}

