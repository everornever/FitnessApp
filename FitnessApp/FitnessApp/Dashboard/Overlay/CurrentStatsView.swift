//
//  WeeklyStats.swift
//  Fitness App
//

import SwiftUI

struct CurrentStatsView: View {
    
    // User info
    @ObservedObject var user = User()
    
    // Sheet Views
    //@State private var isShowingWeightView = false
    @State private var isShowingTargetView = false
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            Text("Current Stats")
                .font(.title3)
                .bold()
            
            HStack {
                
                CardViewWeight()
//                    .onTapGesture {
//                        isShowingWeightView.toggle()
//                    }
//                    .sheet(isPresented: $isShowingWeightView) {
//                        WeightView()
//                    }
                
                Spacer(minLength: 20)
                
                CardViewTarget()
                    .onTapGesture {
                        isShowingTargetView.toggle()
                    }
                    .sheet(isPresented: $isShowingTargetView) {
                        TargetView()
                            .background(Color.DS_Overlay)
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

