//
//  WeekView.swift
//  GetMoving
//
//  Created by Leon Kling on 08.09.22.
//

import SwiftUI

struct WeekView: View {
    
    @EnvironmentObject var savedWorkouts: SavedWorkouts
    
    let dayNames = CurrentWeek().getCurrentNames()
    let dayDates = CurrentWeek().getStringDates()
    let locale = Locale.current
    
    
    var body: some View {
        HStack {
            ForEach(0..<7) { index in
                VStack {
                    Text(dayDates[index])
                        .font(.caption)
                        .padding(.bottom)
                    
                    Text(dayNames[index])
                        .font(.caption2)
                }
                .frame(width: 40, height: 80)
                .background(.regularMaterial)
                .cornerRadius(40)
                
                if (index < 6) {
                    Spacer()
                }
                
            }
        }
        .monospacedDigit()
        .lineLimit(1)
        
    } // end Of Body
} // end of View


struct WeekView_Previews: PreviewProvider {
    
    static let myEnvObject = SavedWorkouts()
    
    static var previews: some View {
        WeekView()
            .environmentObject(myEnvObject)
    }
}
