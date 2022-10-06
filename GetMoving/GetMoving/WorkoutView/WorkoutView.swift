//
//  WorkoutView.swift
//  GetMoving
//
//  Created by Leon Kling on 06.09.22.
//

import SwiftUI
import UserNotifications

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
    @StateObject var pauseStopwatch = PauseFunctions()
    
    // Dates
    let currentDate = Date()
    
    // Workout status
    @State private var numberOfExercises = 1
    @State private var exerciseIndex = 0
    @State private var setIndex = 0
    
    //MARK: - BODY
    var body: some View {
        ZStack {
            VStack {
                Text(timeString(time: workoutStopwatch.elapsedTime).hours)
                    .monospacedDigit()
                
                List {
                    ForEach(0..<numberOfExercises, id: \.self) { current in
                        HStack {
                            if (current == exerciseIndex) {
                                Image(systemName: "arrowtriangle.right.fill")
                                    .foregroundColor(.yellow)
                            }
                            Text("\(current + 1). Übung")
                            Spacer()
                            if (setIndex<8){
                                ForEach(0..<setIndex, id: \.self) { index in
                                    
                                    Image(systemName: "checkmark.circle")
                                        .font(.title3)
                                        .foregroundColor(.green)
                                    
                                }
                            } else {
                                ForEach(0..<8, id: \.self) { index in
                                    
                                    Image(systemName: "checkmark.circle")
                                        .font(.title3)
                                        .foregroundColor(.green)
                                    
                                }
                            }
                        }
                        .animation(.linear, value: exerciseIndex)
                    }
                }
                //MARK: - Pause Button
                VStack {
                    Text(timeString(time: pauseStopwatch.timeLeft).minutes)
                        .font(.title)
                    
                    Text("Pause Timer")
                        .foregroundColor(.secondary)
                    
                    
                    HStack {
                        Button {
                            // Back one set
                            if(setIndex > 0) {
                                setIndex -= 1
                            } else {
                                setIndex = 3
                                exerciseIndex -= 1
                            }
                            
                            
                        } label: {
                            Image(systemName: "arrowtriangle.left")
                        }
                        .buttonStyle(.bordered)
                        
                        Button("Pause") {
                            pauseStopwatch.reset()
                            pauseStopwatch.isRunning.toggle()
                            scheduleNotification()
                            
                            setIndex += 1
                            
                        }
                        .buttonStyle(.borderedProminent)
                        .controlSize(.large)
                        .buttonBorderShape(.capsule)
                        
                        Button {
                            // Next Exercise
                            if (setIndex < 1) {
                                // nichts
                            } else {
                                numberOfExercises += 1
                                exerciseIndex += 1
                                setIndex = 0
                            }
                            
                        } label: {
                            Image(systemName: "arrowtriangle.right")
                        }
                        .buttonStyle(.bordered)
                    }
                }
                Spacer()
            }
            //MARK: - Navigation Bar
            .navigationBarTitle("Workout", displayMode: .inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems( leading:
                                    Button {
                endWorkoutAlert = true
            } label: {
                Image(systemName: "xmark")
                    .tint(Color.red)
            }
                .alert("Workout abbrechen", isPresented: $endWorkoutAlert) {
                    Button("Zurück", role: .cancel) {}
                    Button("Abbrechen", role: .destructive) {
                        self.workoutStopwatch.isRunning.toggle()
                        presentationMode.wrappedValue.dismiss()
                    }
                } message: {
                    Text("Bist du sicher du willst dein Workout abbrechen?")
                })
            .navigationBarItems( trailing:
                                    Button {
                saveWorkout()
            } label: {
                Text("Beenden")
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
        self.workoutStopwatch.isRunning.toggle()
        savedWorkouts.workoutArray.append(Workout(exercises: 6, date: currentDate, duration: self.workoutStopwatch.elapsedTime))
        withAnimation {
            isShowPopup = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
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
    
    func scheduleNotification() {
        let center = UNUserNotificationCenter.current()
        center.removeAllDeliveredNotifications()
        center.removeAllPendingNotificationRequests()
        
        let content = UNMutableNotificationContent()
        content.title = "Pause is over"
        content.subtitle = "Get back to work!"
        content.sound = UNNotificationSound.default
        
        // show this notification five seconds from now
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        // choose a random identifier
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        // add our notification request
        center.add(request)
    }
    
}

//MARK: - Preview
struct WorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutView()
    }
}


/*
 ForEach(0..<user.setIndex, id: \.self) { index in
     if (current < exerciseIndex) {
         Image(systemName: "circle.fill")
             .font(.title3)
             .foregroundColor(.green)
     }
     if (current == exerciseIndex) {
         Image(systemName: setIndex <= index ? "circle" : "circle.fill")
             .font(.title3)
             .foregroundColor(setIndex <= index ? .gray : .green)
     }
     if (current > exerciseIndex) {
         Image(systemName: "circle")
             .font(.title3)
             .foregroundColor(.gray)
     }
 */
