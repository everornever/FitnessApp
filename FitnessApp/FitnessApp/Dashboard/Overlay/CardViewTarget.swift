//
//  CardViewTarget.swift
//  Fitness App
//

import SwiftUI

struct CardViewTarget: View {
    
    let week = CurrentWeek().getCurrentWeek()
    
    // User info
    @ObservedObject var user = User()
    
    // Calender
    let calendar = Calendar.current
    
    var body: some View {
        VStack {
            
            

        }
        .frame(maxWidth: .infinity ,maxHeight: .infinity)
        .background(Color.DSOverlay)
        .cornerRadius(10)
        
    }
}

struct CardViewTarget_Previews: PreviewProvider {
    static var previews: some View {
        CardViewTarget()
    }
}
