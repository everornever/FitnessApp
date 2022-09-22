//
//  WeeklyStats.swift
//  GetMoving
//
//  Created by Leon Kling on 09.09.22.
//

import SwiftUI

struct WeeklyStats: View {
    var body: some View {
        HStack {
            VStack {
                Text("🔥")
                    .padding()
                    .background(Color.white)
                    .cornerRadius(20)
                VStack() {
                    Text("80Kg")
                        .bold()
                    
                Text("Whight")
                        .foregroundStyle(.secondary)
                }
            }
            .padding(30)
            .background(Color.green.opacity(0.1))
            .cornerRadius(15)
            
            VStack {
                HStack {
                    Text("⏳")
                        .padding()
                        .background(Color.white)
                        .cornerRadius(20)
                    VStack(alignment: .leading) {
                        Text("4h")
                            .bold()
                        
                    Text("Total time")
                            .foregroundColor(.secondary)
                            .lineLimit(1)
                    }
                    Spacer()
                }
                .padding()
                .background(Color.blue.opacity(0.1))
                .cornerRadius(15)
                
                HStack() {
                    Text("💪")
                        .padding()
                        .background(Color.white)
                        .cornerRadius(20)
                    VStack(alignment: .leading) {
                        Text("18")
                            .bold()
                        
                    Text("Excercises")
                            .foregroundColor(.secondary)
                            .lineLimit(1)
                    }
                    Spacer()
                }
                .padding()
                .background(.thickMaterial)
                .cornerRadius(15)
            }
        }
        .padding(.leading)
        .padding(.trailing)
        .frame(maxWidth: .infinity)
    }
}

struct WeeklyStats_Previews: PreviewProvider {
    static var previews: some View {
        WeeklyStats()
    }
}
