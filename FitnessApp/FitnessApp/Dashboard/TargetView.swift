//
//  TargetView.swift
//  GetMoving
//
//  Created by Leon Kling on 19.10.22.
//

import SwiftUI

struct TargetView: View {
    
    @ObservedObject var user = User()
    
    @State private var value = 0
    @State private var animationAmount = 1.0
    
    var body: some View {
        VStack {
            Rectangle()
                .frame(width: 50, height: 5)
                .cornerRadius(20)
                .foregroundStyle(.secondary)
                .padding()
            Spacer()
            Text("Training goal")
                .fontWeight(.bold)
                .font(.largeTitle)
            VStack {
                
                ZStack {
                    Circle()
                        .foregroundColor(Color.DS_Accent)
                        .frame(width: 250)
                        .overlay(
                            Circle()
                                .stroke(Color.DS_Accent)
                                .scaleEffect(animationAmount)
                                .opacity(2 - animationAmount)
                                .animation(
                                    .easeInOut(duration: 2)
                                    .repeatForever(autoreverses: false),
                                    value: animationAmount
                                )
                                .onAppear {
                                    animationAmount = 2
                                }
                        )
                    
                    Text("\(user.target)")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.DS_Primary)
                }
                
                Spacer()
                
                Stepper("How often do you want to train per week?",value: $user.target,  in: 1...7)
                    .padding()
                    .background(.thinMaterial)
                    .cornerRadius(20)
                
                Spacer()
                
            }
            .padding(40)
            Spacer()
            Spacer()
        }
    }
}

struct TargetView_Previews: PreviewProvider {
    static var previews: some View {
        TargetView()
    }
}
