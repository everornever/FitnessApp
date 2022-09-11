//
//  WeekView.swift
//  GetMoving
//
//  Created by Leon Kling on 08.09.22.
//

import SwiftUI

struct weekDay: Identifiable {
    let id = UUID()
    let name: String
    let date: String
}

struct WeekView: View {
    
    let days = [
        weekDay(name: "Mon", date: "08"),
        weekDay(name: "Tue", date: "09"),
        weekDay(name: "Wed", date: "10"),
        weekDay(name: "Thu", date: "11"),
        weekDay(name: "Fri", date: "12"),
        weekDay(name: "Sat", date: "13"),
        weekDay(name: "San", date: "14")]
    
    var body: some View {
        HStack(spacing: 10) {
            ForEach(days) { days in
                VStack {
                    Text(days.date)
                        .padding(.bottom)
                    
                    Text(days.name)
                        .font(.caption)
                }
                .lineLimit(1)
                .minimumScaleFactor(0.1)
                .padding()
                .background(.regularMaterial)
                .cornerRadius(40)
            }
        }
        .padding()
    }
}

struct WeekView_Previews: PreviewProvider {
    static var previews: some View {
        WeekView()
    }
}
