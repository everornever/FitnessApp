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
            Text("Gewicht")
                .fontWeight(.bold)
            ZStack{
                Circle()
                    .frame(width: 90)
                    .foregroundStyle(Color("SecondColor"))
                Text("\(userInput.formatted()) KG")
                    .fontWeight(.bold)
                    .font(.title2)
            }
        }
        .frame(maxWidth: .infinity,minHeight: 150)
        .background(.white)
        .cornerRadius(20)

    }
}

struct CardViewTarget: View {
    
    let userInput: Int
    
    var body: some View {
        VStack {
            Text("Wochen Ziel")
                .fontWeight(.bold)
            ZStack{
                Circle()
                    .frame(width: 90)
                    .foregroundStyle(Color("FirstColor").opacity(0.3))
                Circle()
                    .frame(width: 70)
                    .foregroundStyle(Color("FirstColor"))
                Text("0 / \(userInput)")
                    .fontWeight(.bold)
                    .font(.title2)
            }
        }
        .frame(maxWidth: .infinity,minHeight: 150)
        .background(.white)
        .cornerRadius(20)

    }
}

struct CardViewScore: View {
    
    var body: some View {
        VStack {
            Text("...")
                .fontWeight(.bold)

        }
        .frame(maxWidth: .infinity,minHeight: 150)
        .background(.white)
        .cornerRadius(20)

    }
}

struct CurrentStatsView: View {
    
    @ObservedObject var user = User()
    
    @State private var isShowingWeightView = false
    @State private var isShowingTargetView = false
    
    var body: some View {
        
        VStack(spacing: 10) {
            CardViewScore()
            HStack {
                CardViewWeight(userInput: user.weight)
                    .onTapGesture {
                        isShowingWeightView.toggle()
                    }
                    .sheet(isPresented: $isShowingWeightView) {
                        WeightView()
                    }
                CardViewTarget(userInput: user.target)
                    .onTapGesture {
                        isShowingTargetView.toggle()
                    }
                    .sheet(isPresented: $isShowingTargetView) {
                        TargetView()
                    }
            }
        }
        .padding(10)
        .background(.regularMaterial)
        .cornerRadius(20)
        
    }
}

struct WeeklyStats_Previews: PreviewProvider {
    static var previews: some View {
        CurrentStatsView()
    }
}

