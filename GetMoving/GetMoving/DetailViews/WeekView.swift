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
    let done: Bool
}

struct WeekView: View {
    
    let days = [
        weekDay(name: "Mon", date: "08", done: false),
        weekDay(name: "Tue", date: "09", done: true),
        weekDay(name: "Wed", date: "10", done: false),
        weekDay(name: "Thu", date: "11", done: false),
        weekDay(name: "Fri", date: "12", done: false),
        weekDay(name: "Sat", date: "13", done: false),
        weekDay(name: "San", date: "14", done: false)]
    
    var body: some View {
        HStack(spacing: 10) {
            ForEach(days) { days in
                if(days.done) {
                    VStack {
                        Text(days.date)
                            .font(.caption)
                            .padding(.bottom)
                        
                        Text(days.name)
                            .font(.caption2)
                    }
                    .frame(width: 40, height: 80)
                    .lineLimit(1)
                    .background(.green.opacity(0.1))
                    .cornerRadius(40)
                } else {
                    VStack {
                        Text(days.date)
                            .font(.caption)
                            .padding(.bottom)
                        
                        Text(days.name)
                            .font(.caption2)
                    }
                    .frame(width: 40, height: 80)
                    .lineLimit(1)
                    .background(.regularMaterial)
                    .cornerRadius(40)
                }
                
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
