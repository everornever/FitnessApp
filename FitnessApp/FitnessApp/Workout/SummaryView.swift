//
//  SummaryView.swift
//  Fitness App
//
//  Created by Leon Kling on 09.01.23.
//

import SwiftUI

struct SummaryView: View {
    
    // User Info
    @EnvironmentObject var userObject: UserObject
    
    // current week data
    let week = CurrentWeek()
    
    @State private var select = false
    
    var body: some View {
        ZStack {
            
            ContainerRelativeShape().fill(Color.Layer1)
                .ignoresSafeArea()
            
            VStack {
                
                Spacer()
                
                Image(systemName: "trophy.fill")
                    .font(.system(size: 80))
                    .foregroundColor(Color.yellow)
                    .imageScale(.large)
                    .padding()
                    .background(Color.Layer2)
                    .cornerRadius(100)
                
                Text("Good Job!")
                    .font(.title)
                    .bold()
                
                Text("This is your \(week.getWorkoutsDoneAmount()). workout this week.")
                    .foregroundColor(.SingleLight)
                
                Spacer()
                
                VStack() {
                    
                    HStack(spacing: 30) {
                        Label("10.10.10", systemImage: "calendar")
                        Label("00:00 min", systemImage: "timer")
                        Label("6", systemImage: "dumbbell.fill")
                    }
                    .foregroundColor(.SingleLight)
                    .padding(10)
                    
                    HStack(spacing: 30) {
                        Label("Stretching", systemImage: "figure.cooldown")
                            .foregroundColor(.red)
                        
                        Label("Warm Up", systemImage: "figure.run")
                            .foregroundColor(.green)
                    }
                    .padding(10)
                
                
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.Layer2)
                .cornerRadius(20)
                
                VStack(alignment:.leading) {
                    Text("Add a Tag to your workout")
                        .font(.headline)
                    
                    ScrollView(.horizontal) {
                        HStack(spacing: 20) {
                            ForEach(0..<7) { tag in
                                Button {
                                    // tag name save
                                    select.toggle()
                                } label: {
                                    Label("TagName", systemImage: "questionmark.circle.fill")
                                }
                                .padding(10)
                                .buttonBorderShape(.capsule)
//                                .overlay(
//                                    RoundedRectangle(cornerRadius: 20)
//                                        .stroke(Color.SingleAccent, lineWidth: 5)
//                                )
                            }
                        }
                        .padding(10)
                    }

                    
                }
                .padding()
                .background(Color.Layer2)
                .cornerRadius(20)
                
                Spacer()
                Spacer()
                
                
                
                
                
            }
            .padding()
        }
    }
}

struct SummaryView_Previews: PreviewProvider {
    static var previews: some View {
        SummaryView()
            .environmentObject(UserObject())
    }
}
