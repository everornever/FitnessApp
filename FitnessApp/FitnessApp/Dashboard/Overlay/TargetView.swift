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
                    Image(systemName: "xmark")
                        .padding(10)
                        .foregroundColor(Color.DS_Primary)
                        .background(Color.DS_Background)
                        .cornerRadius(40)
                }
            }
            .padding(.top)
            
            Chart {
                ForEach(savedWorkouts.workoutArray) { shape in
                    BarMark(
                        x: .value("Calender Week", calendar.component(.weekOfYear, from: shape.date)),
                        y: .value("Amount of Workouts", 5)
                    )
                    .foregroundStyle(Color.DS_Accent)
                }
            }
            .padding()
            .background(Color.DS_Background)
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
            .background(Color.DS_Background)
            .cornerRadius(10)
            
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
            .background(Color.DS_Background)
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
            .background(Color.DS_Background)
            .cornerRadius(10)
            
            
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
}

struct TargetView_Previews: PreviewProvider {
    static var previews: some View {
        let example = SavedWorkouts()
        
        example.workoutArray = [Workout(id: UUID(),exercises: 6, date: Date.now, duration: 3600),
                                Workout(id: UUID(),exercises: 6, date: Date.now.addingTimeInterval(-86400), duration: 3000),
                                Workout(id: UUID(),exercises: 6, date: Date.now.addingTimeInterval(-166400), duration: 4000)]
        
        return TargetView().environmentObject(example)
    }
}

