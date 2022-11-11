//
//  WeeklyStats.swift
//  GetMoving
//
//  Created by Leon Kling on 09.09.22.
//

import SwiftUI

struct CardViewWeight: View {
    
    let userInput: Double
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "scalemass.fill")
                    .padding(10)
                    .background(Color.DS_Overlay)
                    .cornerRadius(40)
                
                Spacer()
                
                Text("\(userInput.formatted())")
                    .font(.title.weight(.bold))
                
                Text("Kg")
                    .font(.headline)
                    .fontWeight(.light)
                    .padding(.leading, -5)
                    .padding(.top)
            }
            .padding()
            
            
            Spacer()

        }
        .frame(maxWidth: .infinity ,maxHeight: .infinity)
        .background(Color.DS_Background)
        .cornerRadius(20)
        
    }
}

struct CardViewTarget: View {
    
    let userInput: Int
    
    let week = CurrentWeek().getCurrentWeek()
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "target")
                    .padding(10)
                    .background(Color.DS_Overlay)
                    .cornerRadius(40)
                
                Spacer()
                
                Text("\(checkTarget()) / \(userInput)")
                    .font(.title.weight(.bold))
                

            }
            .padding()
            
            
            Spacer()

        }
        .frame(maxWidth: .infinity ,maxHeight: .infinity)
        .background(Color.DS_Background)
        .cornerRadius(20)
        
    }
    
    func checkTarget() -> Int {
        
        var workoutsDone = 0
        
        for ( _ , value) in week.enumerated() {
            if ( value.workoutDone) {
                workoutsDone += 1
            }
        }
        
        return workoutsDone
    }
}

struct CardViewScore: View {
    
    var body: some View {
        VStack {

            
        }
        .frame(maxWidth: .infinity ,maxHeight: .infinity)
        .background(Color.DS_Background)
        .cornerRadius(20)
        
    }
}

// MARK: - main View
struct CurrentStatsView: View {
    
    @ObservedObject var user = User()
    
    @State private var isShowingWeightView = false
    @State private var isShowingTargetView = false
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            Text("Aktuelle Werte")
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
                    }
                
            }
            
            Text("Aktuelle Streak")
                .font(.title3)
                .bold()
                .padding(.top)
            
            CardViewScore()
        }
        .padding(10)
        .background(Color.DS_Overlay)
        .cornerRadius(20)
        
    }
}

// MARK: - PreView
struct WeeklyStats_Previews: PreviewProvider {
    static var previews: some View {
        CurrentStatsView()
            .frame(height: 500)
    }
}

