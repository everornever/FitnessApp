//
//  ProgressRow.swift
//  Fitness App
//

import SwiftUI

struct ProgressRow: View {
    
    let date: String
    let exercises: Int
    let time: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    Text("\(exercises)")
                        .font(.title3)
                        .bold()
                    Text("Exercises")
                        .font(.headline)
                }
                Text(date)
                    .foregroundColor(Color.DS_Light)
            }
            .padding(.leading)
            
            Spacer()
            
            VStack(alignment: .leading) {
                HStack {
                    Text(time)
                        .font(.title2)
                        .bold()
                    Text("min")
                        .foregroundColor(Color.DS_Light)
                }
            }
        }
    }
}

struct ProgressRow_Previews: PreviewProvider {
    static var previews: some View {
        ProgressRow(date: "10. Nov 2022", exercises: 6, time: "00:10")
    }
}
