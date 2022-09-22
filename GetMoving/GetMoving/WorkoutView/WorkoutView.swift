//
//  WorkoutView.swift
//  GetMoving
//
//  Created by Leon Kling on 06.09.22.
//

import SwiftUI

struct WorkoutView: View {
    
    // Dismissing View after cencel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    // User Settings
    @ObservedObject var user = User()
    
    // User Defaults Workouts
    @EnvironmentObject var savedWorkouts: SavedWorkouts
    
    // View toogles
    @State private var endWorkoutAlert = false
    @State private var isShowPopup: Bool = false
    
    // Workout Timer
    @StateObject var workoutStopwatch = StopwatchFunctions()
    
    // Pause Timer

    
    // Dates
    let currentDate = Date()
    let currentStartTime = Date().formatted(date: .omitted, time: .shortened)
    
    //MARK: - BODY
    var body: some View {
        ZStack {
            VStack {
                Text(timeString(time: self.workoutStopwatch.elapsedTime).hours)
                    .monospacedDigit()

                List {
                    Section {
                        HStack {
                            Text("🏃‍♂️")
                            Text("Wormup")
                            Spacer()
                            Image(systemName: "circle")
                                .font(.title3)
                        }
                    }
                    ForEach(1..<user.numberOfExercises + 1, id: \.self) { index in
                        HStack {
                            Image(systemName: "\(index).square")
                            Text("Exercise")
                            Spacer()
                            ForEach(0..<user.numberOfSets, id: \.self) { _ in
                                Image(systemName: "circle")
                                    .font(.title3)
                            }
                        }
                    }
                }
                VStack {
                    Text("01:30")
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
                        
                        Button("Pause") {
                        }
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
                        self.workoutStopwatch.isRunning.toggle()
                        presentationMode.wrappedValue.dismiss()
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
            if isShowPopup {
                GeometryReader { _ in
                    PopupView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding(.horizontal, 35)
                }
            }
        }
        .onAppear {
            self.workoutStopwatch.isRunning.toggle()
        }
    }
    //MARK: - FUNCTIONS
    func saveWorkout() {
        savedWorkouts.workoutArray.append(Workout(exercises: 6, date: currentDate, duration: self.workoutStopwatch.elapsedTime))
        withAnimation {
            isShowPopup = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    // make extension!!
    // Convert the time into 24hr (24:00:00) format
    // hours returns 00:00:00
    // minutes returns 00:00
    func timeString(time: Double) -> (hours: String, minutes: String) {
        let hours   = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return (String(format:"%02i:%02i:%02i", hours, minutes, seconds), String(format:"%02i:%02i", minutes, seconds))
    }
    
}

//MARK: - Preview
struct WorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutView()
    }
}
