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
    
    // In Use
    @State private var endWorkoutAlert = false
    @State private var isShowPopup: Bool = false
    
    // Timer
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    // Dates
    let currentDate = Date().formatted(date: .abbreviated, time: .omitted)
    let currentStartTime = Date().formatted(date: .omitted, time: .shortened)
    
    //MARK: - BODY
    var body: some View {
        
        ZStack {
            VStack {
                Text("00:00")
//                    .onReceive(timer) { input in
//                        currentDate = input
//                    }
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
                VStack {
                    Text("00:00")
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
                            // Next set
                        } label: {
                            Image(systemName: "arrowtriangle.right")
                        }
                        .buttonStyle(.bordered)
                    }
                }
                Spacer()
                Spacer()
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
            
            // PopupView
            if self.isShowPopup {
                GeometryReader { _ in
                    PopupView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding(.horizontal, 35)
                }
            }
        }
    }
    //MARK: - FUNCTIONS
    func saveWorkout() {                                        // date has not to be a string
        savedWorkouts.workoutArray.append(Workout(exercises: 6, date: "\(currentDate)", duration: "0:90"))
        withAnimation {
            isShowPopup = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            self.presentationMode.wrappedValue.dismiss()
        }
    }
}

//MARK: - Preview
struct WorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutView()
    }
}
