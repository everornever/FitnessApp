//
//  CardViewWeight.swift
//  Fitness App
//

import SwiftUI
import Charts

struct WeightCardView: View {
    
    // User Info
    @EnvironmentObject var userObject: UserObject
    
    var body: some View {
        VStack {
            VStack{
                Text("\(userObject.props.weightEntries.last?.weight.dezimalString() ?? 00.00.dezimalString())")
                    .font(.headline)
                
                Text("KG")
                    .font(.caption)
                    .foregroundColor(Color.SingleLight)
            }
            .padding()
            
            Chart(userObject.props.weightEntries.suffix(28)) {
                AreaMark(x: .value("Date", $0.date),
                         y: .value("Weight", $0.weight))
                .lineStyle(StrokeStyle(lineWidth: 4))
                .symbol(Circle().strokeBorder(lineWidth: 2))
                .interpolationMethod(.cardinal)
                .foregroundStyle(Gradient(colors: [Color.SingleAccentTwo, Color.clear]))
            }
            .chartYAxis(.hidden)
            .chartXAxis(.hidden)
        }
        .frame(maxWidth: .infinity ,maxHeight: .infinity)
        .background(Color.Layer3)
        .cornerRadius(20)
    }
}

// MARK: - Preview
struct WeightCardView_Previews: PreviewProvider {
    static var previews: some View {
        WeightCardView()
            .environmentObject(UserObject())
    }
}
