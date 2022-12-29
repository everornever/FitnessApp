//
//  WeeklyStats.swift
//  Fitness App
//

import SwiftUI

struct CurrentStatsView: View {
    
    // User Info
    @EnvironmentObject var user: UserObject
    
    // Saved Workouts
    @EnvironmentObject var workouts: WorkoutObject
    
    // Sheet Views
    @State private var isShowingWeightView = false
    @State private var isShowingTargetView = false
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            Text("Current Stats")
                .font(.title3)
                .bold()
            
            HStack {
                
                // Target Card
                Button {
                    isShowingWeightView.toggle()
                } label: {
                    WeightCardView()
                }
                .sheet(isPresented: $isShowingWeightView) {
                    WeightView()
                }
                
                Spacer(minLength: 20)
                
                // Target Card
                Button {
                    isShowingTargetView.toggle()
                } label: {
                    CardViewTarget()
                }
                .sheet(isPresented: $isShowingTargetView) {
                    TargetView()
                }
                
            }
            
            Text("Streak")
                .font(.title3)
                .bold()
            
            CardViewScore()
        }
        .padding(20)
        .background(Color.DSBackground)
        .cornerRadius(10)
        
    }
}

// MARK: - PreView
struct WeeklyStats_Previews: PreviewProvider {
    static var previews: some View {
        CurrentStatsView()
            .frame(height: 500)
            .environmentObject(UserObject())
            .environmentObject(WorkoutObject())
        
    }
}

