//
//  CardViewTarget.swift
//  Fitness App
//

import SwiftUI

struct GoalCardView: View {
    
    // User Info
    @EnvironmentObject var userObject: UserObject
    
    // current week data
    let week = CurrentWeek()
    
    // MARK: - Card
    var body: some View {
        VStack {
            VStack{
                Text("\(week.getWorkoutsDoneAmount()) / \(userObject.props.weeklyGoal)")
                    .font(.headline)
                
                Text("Weekly Target")
                    .font(.caption)
                    .foregroundColor(Color.SingleLight)
            }
                
            HStack(spacing: 8) {
                ForEach(0..<6) { index in
                    VStack(alignment: .center) {
                        
                        BarView(amount: userObject.getCurrentWorkoutAmount(weekNumber: Date.now.getLastSixWeeks()[index]), target: userObject.props.weeklyGoal)
                        
                        Text("\(Date.now.getLastSixWeeks()[index])")
                            .monospacedDigit()
                            .font(.caption2)
                            .foregroundColor(Color.SingleLight)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity ,maxHeight: .infinity)
        .padding()
        .background(Color.Layer3)
        .cornerRadius(20)
    }
}

// MARK: - Bar View
struct BarView: View {
    
    let amount: Int
    let target: Int
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                
                RoundedRectangle(cornerRadius: 3)
                .frame(width: 8)
                .foregroundColor(Color.SingleLight.opacity(0.2))
                
                RoundedRectangle(cornerRadius: 3)
                    .frame(width: 8, height: geometry.size.height * calculateHight())
                    .foregroundColor(checkGreen() ? Color.SingleAccent : Color.primary)
            }
            .position(x: geometry.frame(in: .local).midX, y: geometry.frame(in: .local).midY)
        }
    }
    
    func checkGreen() -> Bool{
        if (amount >= target) {
            return true
        } else {
            return false
        }
    }
    
    func calculateHight() -> Double {
        if (target == 0)  {
            return 0
        }
        else if (amount <= target) {
            return Double(amount) / Double(target)
        }
        else {
            return 1
        }
    }
}

// MARK: - PreView
struct CardViewTarget_Previews: PreviewProvider {
    static var previews: some View {
        GoalCardView()
            .environmentObject(UserObject())
    }
}
