//
//  WeeklyStats.swift
//  GetMoving
//
//  Created by Leon Kling on 09.09.22.
//

import SwiftUI

struct CurrentStatsView: View {
    var body: some View {
        
        HStack {
            Spacer()
            Text("Placeholder")
                .foregroundColor(.gray)
                .frame(height: 150)
            Spacer()
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
