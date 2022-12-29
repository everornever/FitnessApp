//
//  ProgressRow.swift
//  Fitness App
//

import SwiftUI

struct ProgressRow: View {
    
    let date: String
    let exercises: Int
    let time: String
    let day: String
    let weeknumber: String
    
    var body: some View {
        HStack {
            Text("\(day)")
                .font(.title3)
                .bold()
                .frame(width: 50, height: 50)
                .background(Color.DSLight.opacity(0.2))
                .cornerRadius(40)
            
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    Text("\(exercises)")
                        .font(.title3)
                        .bold()
                    Text("Exercises")
                        .font(.headline)
                }
                HStack {
                    Text("\(date) |")
                        .foregroundColor(Color.DSLight)
                        .font(.callout)
                    
                    Text("W\(weeknumber)")
                        .foregroundColor(Color.DSSecondaryAccent)
                        .font(.callout)
                }
            }
            .padding(.leading)
            
            Spacer()
            
            VStack(alignment: .leading) {
                HStack {
                    Text(time)
                        .font(.title2)
                        .bold()
                    Text("min")
                        .foregroundColor(Color.DSLight)
                }
            }
        }
        .listRowBackground(Color.DSSecondaryOverlay)
    }
}

// MARK: - Preview
struct ProgressRow_Previews: PreviewProvider {
    static var previews: some View {
        ProgressRow(date: "10. Nov 2022", exercises: 6, time: "00:10", day: Date.now.formatted(.dateTime.weekday(.short)), weeknumber: "52")
    }
}
