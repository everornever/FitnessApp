//
//  WeeklyStats.swift
//  Fitness App
//

import SwiftUI

struct CurrentStatsView: View {
    
    // User info
    @ObservedObject var user = User()
    
    // Sheet Views
    @State private var isShowingWeightView = false
    @State private var isShowingTargetView = false
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            Text("Current Stats")
                .font(.title3)
                .bold()
            
            HStack {
                
                CardViewWeight(userInput: user.weight)
                    .onTapGesture {
                        isShowingWeightView.toggle()
                    }
                    .sheet(isPresented: $isShowingWeightView) {
                        WeightView()
                    }
                
                Spacer(minLength: 20)
                
                CardViewTarget(userInput: user.target)
                    .onTapGesture {
                        isShowingTargetView.toggle()
                    }
                    .sheet(isPresented: $isShowingTargetView) {
                        TargetView()
                            .presentationDragIndicator(.visible)
                    }
                
            }
            
            Text("Streak")
                .font(.title3)
                .bold()
            
            CardViewScore()
        }
        .padding(20)
        .background(Color.DS_Overlay)
        .cornerRadius(10)
        
    }
}

// MARK: - PreView
struct WeeklyStats_Previews: PreviewProvider {
    static var previews: some View {
        CurrentStatsView()
            .frame(height: 500)
    }
}

