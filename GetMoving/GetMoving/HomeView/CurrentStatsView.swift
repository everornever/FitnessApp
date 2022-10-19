//
//  WeeklyStats.swift
//  GetMoving
//
//  Created by Leon Kling on 09.09.22.
//

import SwiftUI

struct CurrentStatsView: View {
    
    @ObservedObject var user = User()
    
    @State private var isShowingWeightView = false
    @State private var isShowingTargetView = false
    
    var body: some View {
        
        HStack(spacing: 0) {
            VStack{
                Text("Gewicht")
                    .fontWeight(.bold)
                ZStack{
                    Circle()
                        .frame(width: 90)
                        .foregroundStyle(Color("SecondColor"))
                    Text("\(user.weight.formatted()) KG")
                        .fontWeight(.bold)
                        .font(.title2)
                }
                
            }
            .frame(width: 160, height: 160)
            .background(Color.white)
            .cornerRadius(20)
            .padding([.top, .bottom, .leading], 10)
            .onTapGesture {
                isShowingWeightView.toggle()
            }
            .sheet(isPresented: $isShowingWeightView) {
                WeightView()
            }
            
            VStack{
                Text("Wochen Ziel")
                    .fontWeight(.bold)
                ZStack{
                    Circle()
                        .frame(width: 90)
                        .foregroundStyle(Color("FirstColor").opacity(0.3))
                    Circle()
                        .frame(width: 70)
                        .foregroundStyle(Color("FirstColor"))
                    Text("0 / \(user.target)")
                        .fontWeight(.bold)
                        .font(.title2)
                }
                
            }
            .frame(width: 160, height: 160)
            .background(Color.white)
            .cornerRadius(20)
            .padding([.trailing, .top, .bottom, .leading], 10)
            .onTapGesture {
                isShowingTargetView.toggle()
            }
            .sheet(isPresented: $isShowingTargetView) {
                TargetView()
            }
        }
        .background(Material.regular)
        .cornerRadius(20)
        
    }
}

struct WeeklyStats_Previews: PreviewProvider {
    static var previews: some View {
        CurrentStatsView()
    }
}
