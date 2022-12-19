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
    
    // Dismiss Button
    @Environment(\.dismiss) var dismiss
    
    // Calendar
    let calendar = Calendar.current
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            HStack { // Top
                Text("Weekly Target")
                    .font(.title)
                    .bold()
                Spacer()
                Button { dismiss() } label: {
                    RoundButton(tint: Color.DSPrimary, back: Color.DSBackground, cancel: true)
                }
            }
            .padding(.top)
            
            // MARK: - Chart
            VStack(alignment: .leading) {
                HStack {
                    Text("Your workouts in the last 6 Weeks")
                        .font(.caption2)
                        .foregroundColor(Color.DSLight)
                    
                    Spacer()
                    
                    Text("Current Week: \(Date.now.getWeekNumber())")
                        .font(.caption2)
                        .foregroundColor(Color.DSLight)
                }
                
                Chart() {
                    
                    RuleMark(y: .value("Goal", user.target))
                        .foregroundStyle(Color.DSSecondaryAccent)
                        .lineStyle(StrokeStyle(lineWidth: 4, dash: [8]))
                        .annotation(alignment: .leading) {
                            Text("Target")
                                .font(.caption2)
                                .foregroundColor(Color.DSLight)
                        }
                    
                    ForEach(savedWorkouts.getLastSixWeeks(), id: \.self) { week in
                        BarMark(
                            x: .value("Calendar Week", "\(week)"),
                            y: .value("Amount of Workouts", savedWorkouts.getWorkoutAmount(number: week))
                        )
                        .foregroundStyle((savedWorkouts.getWorkoutAmount(number: week) >= user.target) ? Color.DSAccent : Color.DSPrimary )
                    }
                    
                }
                .frame(height: 300)
                .chartXAxisLabel() {
                    Text("Calendar Week")
                }
            }
            .padding()
            .background(Color.DSBackground)
            .cornerRadius(20)
            
            // MARK: - Cards
            HStack { // Weekly Target
                VStack(alignment: .leading) {
                    Text("Weekly Target")
                        .font(.subheadline)
                        .foregroundColor(.DSLight)
                    Text("\(user.target)")
                        .font(.title2)
                        .bold()
                }
                Spacer()
                HStack {
                    Button("-") { subtractTarget() }
                        .buttonStyle(.borderedProminent)
                        .tint(Color.DSPrimary)
                        .foregroundColor(Color.DSPrimary_RV)
                    Button("+") { addTarget() }
                        .buttonStyle(.borderedProminent)
                        .tint(Color.DSPrimary)
                        .foregroundColor(Color.DSPrimary_RV)
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
                            .foregroundColor(.DSLight)
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
                            .foregroundColor(.DSLight)
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
        .background(Color.DSOverlay)
    }
    
    // MARK: - Functions
    
    // Add / Subtract target value
    func addTarget() {
        if (user.target < 7) {
            user.target += 1
        }
    }
    
    func subtractTarget() {
        if (user.target > 1) {
            user.target -= 1
        }
    }
    
    // get longest workout time
    func longestWorkout() -> String {
        let max = savedWorkouts.workoutArray.map { $0.duration }.max()
        return max?.timeString().hours ?? "00:00"
    }
}

// MARK: - Preview
struct TargetView_Previews: PreviewProvider {
    static let previewObject = SavedWorkouts()
    static var previews: some View {
        TargetView().environmentObject(previewObject)
    }
}

