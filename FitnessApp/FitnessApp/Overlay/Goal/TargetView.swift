//
//  TargetView.swift
//  Fitness App
//

import SwiftUI
import Charts

struct TargetView: View {
    
    // User Info
    @EnvironmentObject var userObject: UserObject
    
    // Dismiss Button
    @Environment(\.dismiss) var dismiss
    
    // Calendar
    let calendar = Calendar.current
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            // MARK: - Top
            HStack {
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
                    
                    Text("Current Week: \(calendar.component(.weekOfYear, from: Date.now))")
                        .font(.caption2)
                        .foregroundColor(Color.DSLight)
                }
                
                Chart() {
                    
                    RuleMark(y: .value("Goal", userObject.props.weeklyGoal))
                        .foregroundStyle(Color.DSSecondaryAccent)
                        .lineStyle(StrokeStyle(lineWidth: 4, dash: [8]))
                        .annotation(alignment: .leading) {
                            Text("Target")
                                .font(.caption2)
                                .foregroundColor(Color.DSLight)
                        }
                    
                    ForEach(Date.now.getLastSixWeeks(), id: \.self) { week in
                        BarMark(
                            x: .value("Calendar Week", "\(week)"),
                            y: .value("Amount of Workouts", userObject.getCurrentWorkoutAmount(weekNumber: week))
                        )
                        .foregroundStyle((userObject.getCurrentWorkoutAmount(weekNumber: week) >= userObject.props.weeklyGoal) ? Color.DSAccent : Color.DSPrimary )
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
                    Text("\(userObject.props.weeklyGoal)")
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
                        Text("\(userObject.props.workouts.count)")
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
        if (userObject.props.weeklyGoal < 7) {
            userObject.props.weeklyGoal += 1
        }
    }
    
    func subtractTarget() {
        if (userObject.props.weeklyGoal > 1) {
            userObject.props.weeklyGoal -= 1
        }
    }
    
    // get longest workout time
    func longestWorkout() -> String {
        let max = userObject.props.workouts.map { $0.duration }.max()
        return max?.timeString().hours ?? "00:00"
    }
}

// MARK: - Preview
struct TargetView_Previews: PreviewProvider {
    static var previews: some View {
        TargetView()
            .environmentObject(UserObject())
    }
}

