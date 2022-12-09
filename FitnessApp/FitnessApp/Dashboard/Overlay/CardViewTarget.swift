//
//  CardViewTarget.swift
//  Fitness App
//

import SwiftUI
import Charts

struct CardViewTarget: View {
    
    // User info
    @ObservedObject var user = User()
    
    // current week data
    let week = CurrentWeek()
    
    // Saved Workouts
    @EnvironmentObject var savedWorkouts: SavedWorkouts
    
    var body: some View {
        VStack {
            VStack{
                Text("\(week.getWorkoutsDoneAmount()) / \(user.target)")
                    .font(.headline)
                    .foregroundColor(.DSPrimary)
                
                Text("Weekly Target")
                    .font(.caption)
                    .foregroundColor(Color.DSLight)
            }
            .padding(.top)
                
            HStack {
                ForEach(0..<6) { index in
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: 5)
                        .foregroundColor(Color.DSLight.opacity(0.2))
                }
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
        .frame(maxWidth: .infinity ,maxHeight: .infinity)
        .background(Color.DSOverlay)
        .cornerRadius(20)
    }
    
    struct CardViewTarget_Previews: PreviewProvider {
        static let previewObject = SavedWorkouts()
        static var previews: some View {
            CardViewTarget().environmentObject(previewObject)
        }
    }
}
