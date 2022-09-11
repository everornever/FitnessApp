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
    
    @EnvironmentObject var savedWorkouts: SavedWorkouts
    
    @State private var exercise = 1
    @State private var set = 0
    @State private var pauseTimer = false
    @State private var endWorkoutAlert = false
    
    @State private var isShowPopup: Bool = false
    @State private var workoutTime = 0
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        
        ZStack {
            VStack(spacing: 0) {
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
                    }
                }
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
                saveWorkout()
            } label: {
                Text("Finish")
            })
            
            if self.isShowPopup {
                GeometryReader { _ in
                    PopupView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding(.horizontal, 35)
                }
            }
        }
    }
    
    func saveWorkout() {
        savedWorkouts.workoutArray.append(Workout(exercises: 6, date: "Saved", duration: "0:90"))
        withAnimation {
            isShowPopup = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            self.presentationMode.wrappedValue.dismiss()
        }
        
        
    }
    
}

struct WorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutView()
    }
}
