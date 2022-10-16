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
    @State var numberOfExercises = 1
    @State var exerciseIndex = 0
    @State var numberOfSets = [0]
    
    //MARK: - BODY
    var body: some View {
        ZStack {
            VStack {
                Text(workoutStopwatch.elapsedTime.timeString().hours)
                    .monospacedDigit()
                
                // MARK: - Exercise List
                List {
                    ForEach(0..<numberOfExercises, id: \.self) { index in
                        HStack {
                            if(exerciseIndex == index) {
                                Image(systemName: "arrowtriangle.right.fill")
                                    .foregroundColor(.yellow)
                            }
                            
                            Text(" \(index+1). Übung")
                            
                            Spacer()
                            
                            ForEach(0..<numberOfSets[index], id: \.self) { _ in
                                Image(systemName: "circlebadge.fill")
                                    .foregroundColor(.green)
                                    .font(.title2)
                            }
                        }
                        .animation(.linear, value: exerciseIndex)
                    }
                }
                
                // MARK: - Pause Button
                VStack {
                    Text(pauseStopwatch.timeLeft.timeString().seconds)
                        .font(.title)
                        .monospacedDigit()
                    
                    Text("Pause Timer")
                        .foregroundColor(.secondary)
                    
                    HStack {
                        // Back Button
                        Button {
                            if(numberOfSets[exerciseIndex] > 1) {
                                numberOfSets[exerciseIndex] -= 1
                            }
                            else {
                                numberOfExercises -= 1
                                numberOfSets.remove(at: exerciseIndex)
                                exerciseIndex -= 1
                            }
                        } label: {
                            Image(systemName: "arrowtriangle.left")
                        }
                        .buttonStyle(.bordered)
                        
                        // Pause Button
                        Button("Pause") {
                            pauseStopwatch.reset()
                            pauseStopwatch.isRunning.toggle()
                            scheduleNotification()
                            if numberOfSets[exerciseIndex]<8 {
                                numberOfSets[exerciseIndex] += 1
                            }
                        }
                        .buttonStyle(.borderedProminent)
                        .controlSize(.large)
                        .buttonBorderShape(.capsule)
                        
                        // Next exercise
                        Button {
                            numberOfSets.append(0)
                            numberOfExercises += 1
                            exerciseIndex += 1
                        } label: {
                            Image(systemName: "arrowtriangle.right")
                        }
                        .buttonStyle(.bordered)
                    }
                }
                
                Spacer()
            }
            // MARK: - Navigation Bar
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
                        workoutStopwatch.isRunning.toggle()
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
            workoutStopwatch.isRunning.toggle()
        }
    }
    // MARK: - FUNCTIONS
    
    func saveWorkout() {
        // stop timers
        workoutStopwatch.isRunning.toggle()
        pauseStopwatch.isRunning.toggle()
        
        // save workout stats
        savedWorkouts.workoutArray.append(Workout(exercises: 6, date: currentDate, duration: self.workoutStopwatch.elapsedTime))
        
        // show popup
        withAnimation {
            isShowPopup = true
        }
        
        // dissmiss View after a few seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    func scheduleNotification() {
        let center = UNUserNotificationCenter.current()
        center.removeAllDeliveredNotifications()
        center.removeAllPendingNotificationRequests()
        
        let content = UNMutableNotificationContent()
        content.title = "Pause ist vorbei"
        content.subtitle = "zurück an die Arbeit!"
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: user.pauseTimer, repeats: false)
        
        // choose a random identifier
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        center.add(request)
    }
    
}

// MARK: - Preview
struct WorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutView()
    }
}



