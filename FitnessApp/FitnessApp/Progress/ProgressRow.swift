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
    let weekNumber: String
    let warmup: Bool
    let stretching: Bool
    
    var body: some View {
        HStack {
            // Icon
            Text("\(day)")
                .font(.title3)
                .bold()
                .frame(width: 50, height: 50)
                .background(Color.SingleLight.opacity(0.2))
                .cornerRadius(40)
            
            VStack(alignment: .leading, spacing: 5) {
                
                // Exercises - Time
                HStack {
                    Text("\(exercises) Exercises")
                        .font(.headline)
                    
                    Spacer()
                    
                    Text(time)
                        .font(.headline)

                    Text("min")
                        .foregroundColor(Color.SingleLight)
                }
                
                // Date - Week - Plague
                HStack {
                    Text("\(date) |")
                        .foregroundColor(Color.SingleLight)
                        .font(.callout)
                    
                    Text("W\(weekNumber)")
                        .foregroundColor(Color.SingleAccentTwo)
                        .font(.callout)
                    
                    Spacer()
                    
                    if warmup {
                        Image(systemName: "figure.run.circle.fill")
                            .foregroundColor(.SingleAccentTwo)
                    }
                    
                    if stretching {
                        Image(systemName: "figure.cooldown")
                            .tint(.SingleAccent)
                            .foregroundColor(.SingleAccentTwo)
                    }
                    
                    
                }
            }
            .padding(.leading)
        }
        .listRowBackground(Color.Layer3)
    }
}

// MARK: - Preview
struct ProgressRow_Previews: PreviewProvider {
    static var previews: some View {
        ProgressRow(date: "10. Nov 2022", exercises: 6, time: "00:10", day: Date.now.formatted(.dateTime.weekday(.short)), weekNumber: "52", warmup: true, stretching: true)
    }
}
