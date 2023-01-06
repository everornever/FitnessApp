//
//  WeightView.swift
//  GetMoving
//
//  Created by Leon Kling on 19.10.22.
//

import SwiftUI
import Charts

struct WeightView: View {
    
    // User Info
    @EnvironmentObject var userObject: UserObject
    
    // Dismiss Button
    @Environment(\.dismiss) var dismiss
    
    // Calendar
    let calendar = Calendar.current

    var body: some View {
        NavigationStack {
            VStack {
                // MARK: - Top
                HStack {
                    Text("Body Metrics")
                        .font(.title)
                        .bold()
                    Spacer()
                    CancelButton() {
                        dismiss()
                    }
                }
                .padding(.top)
                
                // MARK: - Chart
                VStack(alignment: .leading) {
                    Chart(userObject.props.weightEntries) {
                        
                        AreaMark(
                            x: .value("Date", $0.date),
                            y: .value("Value", $0.weight)
                        )
                        .lineStyle(StrokeStyle(lineWidth: 4))
                        .symbol(Circle().strokeBorder(lineWidth: 2))
                        .interpolationMethod(.cardinal)
                        .foregroundStyle(Gradient(colors: [Color.SingleAccentTwo, Color.clear]))
                    }
                    .frame(height: 300)
                }
                .padding()
                
                // MARK: - Saved Weight
                NavigationLink(destination: WeightList()) {
                    HStack {
                        Text("Progress")
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                    .padding()
                }
                
                Spacer()
            }
            .padding()
        .background(Color.Layer2)
        }
    }
    
    func maxMinValues() -> (Max: Double, Min: Double) {
        let max = userObject.props.weightEntries.map { $0.weight}.max() ?? 00.00
        let min = userObject.props.weightEntries.map { $0.weight}.min() ?? 00.00
        return (Max: max, Min: min)
    }
    
}

// MARK: - Preview
struct WeightView_Previews: PreviewProvider {
    static var previews: some View {
        WeightView()
            .environmentObject(UserObject())
    }
}


