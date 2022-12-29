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
    @EnvironmentObject var user: UserObject
    
    // Weight Object
    @ObservedObject var weightObject = WeightObject()
    
    // Add Weight
    @State private var stepper = WeightObject().savedEntries.last?.weight ?? 60.00
    let step = 00.01
    let disable = false
    
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
                    Button { dismiss() } label: {
                        RoundButton(tint: Color.DSPrimary, back: Color.DSBackground, cancel: true)
                    }
                }
                .padding(.top)
                
                // MARK: - Chart
                VStack(alignment: .leading) {
                    Chart(weightObject.savedEntries) {
                        
                        AreaMark(
                            x: .value("Date", $0.date),
                            y: .value("Value", $0.weight)
                        )
                        .lineStyle(StrokeStyle(lineWidth: 4))
                        .symbol(Circle().strokeBorder(lineWidth: 2))
                        .interpolationMethod(.cardinal)
                        .foregroundStyle(Gradient(colors: [Color.DSSecondaryAccent, Color.clear]))
                    }
                    .frame(height: 300)
                }
                .padding()
                .background(Color.DSBackground)
                .cornerRadius(20)
                
                // MARK: - Save Weight
                VStack(alignment: .leading) {
                    
                    Text("Add your current weight and save it")
                        .font(.subheadline)
                        .foregroundColor(.DSLight)
                    
                    HStack {
                        
                        Text("\(stepper.dezimalString())")
                            .font(.title2)
                            .bold()
                        
                        Stepper("", value: $stepper, step: step)
                    }
                    .padding(.bottom)
                    
                    VStack {
                        MainButton(text: "Save") {
                            weightObject.saveEntry(value: stepper)
                        }
                        .disabled(calendar.isDateInToday(weightObject.savedEntries.last!.date) ? true : false)
                        
                        if(calendar.isDateInToday(weightObject.savedEntries.last!.date)) {
                            Text("You can only save your weight once per day")
                                .font(.subheadline)
                                .foregroundColor(.DSLight)
                        }
                    }
                }
                .padding()
                .background(Color.DSBackground)
                .cornerRadius(10)
                
                // MARK: - Save Weight
                NavigationLink(destination: WeightList()) {
                    HStack {
                        Text("Progress")
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                    .padding()
                    .background(Color.DSBackground)
                    .cornerRadius(10)
                }
                
                Spacer()
            }
            .padding()
        .background(Color.DSOverlay)
        }
    }
    
    func maxMinValues() -> (Max: Double, Min: Double) {
        let max = weightObject.savedEntries.map { $0.weight}.max() ?? 00.00
        let min = weightObject.savedEntries.map { $0.weight}.min() ?? 00.00
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


