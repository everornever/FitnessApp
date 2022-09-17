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
    @State private var workoutTime = 00*00*00
    let workoutTimer = Timer.publish(every: 1,tolerance: 0.5, on: .main, in: .common).autoconnect()
    
    // Pause Timer
    @State private var pauseTime = 90
//    var pauseTimerRunning = false
    let pauseTimer = Timer()
    
    // Dates
    let currentDate = Date().formatted(date: .abbreviated, time: .omitted)
    let currentStartTime = Date().formatted(date: .omitted, time: .shortened)
    
    //MARK: - BODY
    var body: some View {
        
        ZStack {
            VStack {
                Text("\(timeString(time: workoutTime).hours)")
                    .monospacedDigit()
                    .onReceive(workoutTimer){ _ in
                        if workoutTime < 7200 {
                            workoutTime += 1
                            print(workoutTime)
                        } else {
                            workoutTimer.upstream.connect().cancel()
                        }
                    }
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
                    Text("\(timeString(time: pauseTime).minutes)")
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
                            pauseTimerStart()
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
                        workoutTimer.upstream.connect().cancel()
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
    }
    //MARK: - FUNCTIONS
    func saveWorkout() {
        workoutTimer.upstream.connect().cancel()
        savedWorkouts.workoutArray.append(Workout(exercises: 6, date: "\(currentDate)", duration: "\(timeString(time: workoutTime))"))
        withAnimation {
            isShowPopup = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    // Convert the time into 24hr (24:00:00) format
    // hours returns 00:00:00
    // minutes returns 00:00
    func timeString(time: Int) -> (hours: String, minutes: String) {
        let hours   = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return (String(format:"%02i:%02i:%02i", hours, minutes, seconds), String(format:"%02i:%02i", minutes, seconds))
    }
    
    func pauseTimerStart() {
        if pauseTimerRunning {
            pauseTimerStop()
        } else {
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true)  { _ in
                if pauseTime > 0 {
                    pauseTime -= 1
                    print(pauseTime)
                } else {
                    pauseTimerStop()
                }
            }
        }
    }
    
    func pauseTimerStop() {
        pauseTimer.invalidate()
//        pauseTimerRunning = false
        pauseTime = 90 // back to start time
    }
}

//MARK: - Preview
struct WorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutView()
    }
}
