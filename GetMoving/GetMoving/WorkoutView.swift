//
//  WorkoutView.swift
//  GetMoving
//
//  Created by Leon Kling on 06.09.22.
//

import SwiftUI

struct WorkoutView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode> // ???????
    
    @ObservedObject var user = User()
    
    @State private var exercise = 1
    @State private var set = 0
    @State private var pauseTimer = false
    @State private var endWorkoutAlert = false
    
    @State private var workoutTime = 0
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            
            Spacer()
            
            Text("00:00")
            
            
            Spacer()
            
            List {
                Section {
                    HStack {
                        Text("🏃‍♂️")
                        Text("Wormup")
                        Spacer()
                        Image(systemName: "checkmark.circle")
                            .foregroundColor(.green)
                            .font(.title3)
                    }
                    .listRowBackground(Color.gray.opacity(0.1))
                }
                ForEach(1..<7) { index in
                    HStack {
                        Image(systemName: "\(index).square")
                        Text("Exercise")
                        Spacer()
                        Image(systemName: "checkmark.circle")
                            .foregroundColor(.green)
                            .font(.title3)
                        Image(systemName: "circle")
                            .font(.title3)
                        Image(systemName: "circle")
                            .font(.title3)
                        
                    }
                    .listRowBackground(Color.gray.opacity(0.1))
                }
            }
            .onAppear{
                UITableView.appearance().backgroundColor = .clear
            }
            
            
            Spacer()
            
            
            ZStack {                        // own view later
                Rectangle()
                    .frame(maxWidth: .infinity, maxHeight: 200)
                    .foregroundColor(.gray)
                
                VStack {
                    Text("00:00")
                        .foregroundColor(.white)
                        .font(.title)
                    
                    Text("Pause Timer")
                        .foregroundColor(.secondary)
                    
                    
                    HStack {
                        Button {
                            // Back one set
                        } label: {
                            Image(systemName: "arrowtriangle.left")
                        }
                        .buttonStyle(.bordered)
                        
                        Button("Pause") {}
                            .buttonStyle(.borderedProminent)
                            .controlSize(.large)
                            .buttonBorderShape(.capsule)
                        
                        Button {
                            // Back one set
                        } label: {
                            Image(systemName: "arrowtriangle.right")
                        }
                        .buttonStyle(.bordered)
                    }
                }
            }
        }
        .navigationBarTitle("Workout", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems( leading:
                                Button {
            endWorkoutAlert = true
        } label: {
            Image(systemName: "xmark")
                .tint(Color.red)
        }
            .alert("Cancel Workout", isPresented: $endWorkoutAlert) {
                Button("Cancel", role: .cancel) {}
                Button("Quit", role: .destructive) {
                    self.presentationMode.wrappedValue.dismiss()
                }
            } message: {
                Text("Are you shure you want to cancel your Workout?")
            })
        .navigationBarItems( trailing:
                                Button {
            // Save workout
        } label: {
            Text("Finish")
        })
    }
    
}

struct WorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutView()
    }
}
