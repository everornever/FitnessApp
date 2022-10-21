//
//  WorkoutView.swift
//  GetMoving
//
//  Created by Leon Kling on 06.09.22.
//

import SwiftUI
import UserNotifications
import AVFoundation

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
    
    @State var wormUp = false
    @State var coolDown = false
    
    @State var showingNotes = false
    
    // Sound
    let systemSoundID: SystemSoundID = 1050
    
    //MARK: - BODY
    var body: some View {
        ZStack {
            VStack {
                Text(workoutStopwatch.elapsedTime.timeString().hours)
                    .monospacedDigit()
                    .font(.title2)
                    .fontWeight(.bold)
                
                // MARK: - Exercise List
                List {
                    ForEach((0..<numberOfExercises).reversed(), id: \.self) { index in
                        
                        HStack {
                            if(exerciseIndex == index) {
                                Image(systemName: "arrowtriangle.right.fill")
                                    .foregroundColor(Color("FirstColor"))
                            }
                            
                            Text(" \(index+1). Übung")
                                .font(.title3)
                            
                            Spacer()
                            
                            if(numberOfSets[index] < 5) {
                                ForEach(0..<numberOfSets[index], id: \.self) { _ in
                                    
                                    Image(systemName: "circlebadge.fill")
                                        .foregroundColor(Color("FirstColor"))
                                        .font(.title3)
                                    
                                }
                            } else {
                                Image(systemName: "\(numberOfSets[index]).circle")
                                    .foregroundColor(Color("FirstColor"))
                                    .font(.title)
                            }
                            
                        }
                        
                    }
                }
                .cornerRadius(30)
                .padding(20)
                
                // MARK: - Notizen
                Button {
                    showingNotes = true
                } label: {
                    Image(systemName: "list.bullet.clipboard")
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(.black)
                        .font(.title)
                        .padding()
                }
                .background(Color("SecondColor"))
                .cornerRadius(20)
                .padding(.bottom)
                .sheet(isPresented: $showingNotes) {
                    ExerciseListView()
                }
                .padding([.leading, .trailing], 20)
                
                
                // MARK: - Pause Button
                VStack {
                    HStack {
                        Text(pauseStopwatch.timeLeft.timeString().seconds)
                            .font(.title)
                            .fontWeight(.semibold)
                            .monospacedDigit()
                        
                        Button {
                            pauseStopwatch.reset()
                        } label: {
                            Image(systemName: "gobackward")
                                .tint(Color.gray)
                        }
                    }
                    
                    Text("Pause Timer")
                        .foregroundColor(.secondary)
                    
                    
                    HStack(spacing: 40) {
                        // Back Button
                        Button {
                            if(numberOfSets[exerciseIndex] > 0) {
                                numberOfSets[exerciseIndex] -= 1
                            }
                            if((numberOfExercises != 1) && (numberOfSets[exerciseIndex] == 0)) {
                                numberOfExercises -= 1
                                numberOfSets.remove(at: exerciseIndex)
                                exerciseIndex -= 1
                            }
                        } label: {
                            Image(systemName: "backward.end.fill")
                                .font(.title)
                                .foregroundStyle(.black)
                        }
                        
                        
                        // Pause Button
                        Button {
                            pauseStopwatch.reset()
                            pauseStopwatch.isRunning.toggle()
                            AudioServicesPlaySystemSound(systemSoundID)
                            scheduleNotification()
                            
                            if numberOfSets[exerciseIndex]<8 {
                                numberOfSets[exerciseIndex] += 1
                                
                            }
                        }  label: {
                            Image(systemName: "pause.fill")
                                .font(.largeTitle)
                                .foregroundColor(.black)
                                .padding(30)
                        }
                        .tint(Color("FirstColor"))
                        .buttonStyle(.borderedProminent)
                        
                        // Next exercise
                        Button {
                            if(numberOfSets[exerciseIndex] != 0) {
                                numberOfSets.append(0)
                                numberOfExercises += 1
                                exerciseIndex += 1
                            }
                        } label: {
                            Image(systemName: "forward.end.fill")
                                .font(.title)
                                .foregroundStyle(.black)
                        }
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
                        pauseStopwatch.reset()
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
                    .tint(.black)
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



