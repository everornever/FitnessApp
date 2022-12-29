//
//  CardViewWeight.swift
//  Fitness App
//

import SwiftUI
import Charts

struct WeightCardView: View {
    
    // Weight Object
    @ObservedObject var weightObject = WeightObject()
    
    var body: some View {
        VStack {
            VStack{
                Text("\(weightObject.savedEntries.last?.weight.dezimalString() ?? 00.00.dezimalString())")
                    .font(.headline)
                    .foregroundColor(.DSPrimary)
                
                Text("KG")
                    .font(.caption)
                    .foregroundColor(Color.DSLight)
            }
            .padding()
            
            Chart(weightObject.savedEntries.suffix(28)) {
                AreaMark(x: .value("Date", $0.date),
                         y: .value("Weight", $0.weight))
                .lineStyle(StrokeStyle(lineWidth: 4))
                .symbol(Circle().strokeBorder(lineWidth: 2))
                .interpolationMethod(.cardinal)
                .foregroundStyle(Gradient(colors: [Color.DSSecondaryAccent, Color.clear]))
            }
            .chartYAxis(.hidden)
            .chartXAxis(.hidden)
        }
        .frame(maxWidth: .infinity ,maxHeight: .infinity)
        .background(Color.DSOverlay)
        .cornerRadius(20)
    }
}

// MARK: - Preview
struct WeightCardView_Previews: PreviewProvider {
    static var previews: some View {
        WeightCardView()
    }
}
