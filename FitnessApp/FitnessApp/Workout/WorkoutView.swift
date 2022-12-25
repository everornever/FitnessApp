//
//  WorkoutView.swift
//  Fitness App
//

import SwiftUI
import UserNotifications

struct WorkoutView: View {
    
    // Dismissing View after cancel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    // User Info
    @EnvironmentObject var user: UserObject
    
    // User Defaults Workouts
    @EnvironmentObject var savedWorkouts: WorkoutObject
    
    // View toggles
    @State private var endWorkoutAlert = false
    @State private var isShowPopup: Bool = false
    
    // Workout Timer
    @StateObject var workoutStopwatch = StopwatchFunctions()
    
    // Pause Timer
    @StateObject var pauseStopwatch = PauseTimerFunctions()
    
    // Dates
    let currentDate = Date()
    
    // Workout status
    @State var numberOfExercises = 1
    @State var exerciseIndex = 0
    @State var numberOfSets = [0]
    
    // Workout Notes
    @State var showingNotes = false
    
    // Warm Up / Stretching
    @State private var warmUp = false
    @State private var stretching = false
    
    //MARK: - BODY
    var body: some View {
        ZStack {
            
            Color.DSBackground
                .ignoresSafeArea()
            
            VStack {
                Text(workoutStopwatch.elapsedTime.timeString().hours)
                    .monospacedDigit()
                    .font(.title2)
                    .fontWeight(.bold)
                
                // MARK: - Exercise List
                List {
                    
                    if (user.includeStretching) {
                        Section("Press to Check") {
                            HStack {
                                Image(systemName: "figure.strengthtraining.functional")
                                    .font(.title3)
                                
                                Text("Stretching")
                                
                                Spacer()
                                
                                if (stretching) {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(Color.DSAccent)
                                        .font(.title3)
                                }
                                else {
                                    Image(systemName: "circlebadge")
                                        .foregroundColor(Color.primary)
                                        .font(.title2)
                                }
                            }
                            .listRowBackground(Color.DSBackground)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                stretching.toggle()
                            }
                        }
                    }
                    
                    Section("Press Pause Button to add Set") {
                        ForEach((0..<numberOfExercises).reversed(), id: \.self) { index in
                            
                            HStack {
                                if(exerciseIndex == index) {
                                    Image(systemName: "arrowtriangle.right.fill")
                                        .foregroundColor(Color.DSAccent)
                                }
                                
                                Text("\(index+1). Exercise")
                                
                                Spacer()
                                
                                if(numberOfSets[index] < 5) {
                                    ForEach(0..<numberOfSets[index], id: \.self) { _ in
                                        
                                        Image(systemName: "circlebadge.fill")
                                            .foregroundColor(Color.DSAccent)
                                            .font(.title)
                                        
                                    }
                                } else {
                                    Image(systemName: "\(numberOfSets[index]).circle")
                                        .foregroundColor(Color.DSAccent)
                                        .font(.title)
                                }
                                
                            }
                            .listRowBackground(Color.DSBackground)
                            
                        }
                    }
                    
                    if (user.includeWarmup) {
                        Section("Press to Check") {
                            HStack {
                                Image(systemName: "figure.run")
                                    .font(.title3)
                                
                                Text("Warm Up")
                                
                                Spacer()
                                
                                if (warmUp) {
                                    Image(systemName: "circlebadge.fill")
                                        .foregroundColor(Color.DSAccent)
                                        .font(.title)
                                }
                                else {
                                    Image(systemName: "circlebadge")
                                        .foregroundColor(Color.primary)
                                        .font(.title)
                                }
                            }
                            .listRowBackground(Color.DSBackground)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                warmUp.toggle()
                            }
                        }
                    }
                    
                }
                .background(Color.DSOverlay)
                .scrollContentBackground(.hidden)
                .scrollIndicators(.hidden)
                .cornerRadius(30)
                .padding([.leading, .trailing], 20)

                // MARK: - Pause Button
                VStack {
                    HStack {
                        Text(pauseStopwatch.timeLeft.timeString().seconds)
                            .font(.title)
                            .fontWeight(.semibold)
                            .monospacedDigit()
                        
                        Button {
                            pauseStopwatch.stop()
                        } label: {
                            Image(systemName: "gobackward")
                                .tint(Color.DSLight)
                        }
                    }
                    
                    
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
                                .foregroundStyle(Color.DSPrimary)
                        }
                        
                        
                        // Pause Button
                        Button {
                            pauseButtonAction()
                        }  label: {
                            Image(systemName: "pause.fill")
                                .font(.largeTitle)
                                .foregroundColor(.black)
                                .padding(30)
                        }
                        .tint(Color.DSAccent)
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
                                .foregroundStyle(Color.DSPrimary)
                        }
                    }
                }
                .padding(.bottom)
                
                Spacer()
                
                // MARK: - Notizen
                MainButton(text: "", icon: "list.bullet.clipboard", tint: Color.DSOverlay) { showingNotes = true }
                    .padding([.leading, .trailing], 20)
                    .sheet(isPresented: $showingNotes) {
                        ExerciseListView(isPresented: $showingNotes)
                    }
            
            }
            // MARK: - Navigation Bar
            .navigationBarTitle("Workout", displayMode: .inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems( leading:
                                    Button {
                endWorkoutAlert = true
            } label: {
                RoundButton(tint: Color.red, back: Color.DSOverlay, cancel: true)
            }
                .alert("Quit Workout", isPresented: $endWorkoutAlert) {
                    Button("Resume", role: .cancel) {}
                        .tint(Color.DSAccent)
                    Button("Quit", role: .destructive) {
                        pauseStopwatch.stop()
                        workoutStopwatch.isRunning.toggle()
                        presentationMode.wrappedValue.dismiss()
                    }
                } message: {
                    Text("Are you sure you want to quit your current workout?")
                })
            .navigationBarItems( trailing:
                                    Button {
                saveWorkout()
            } label: {
                RoundButton(tint: Color.DSPrimary, back: Color.DSOverlay, cancel: false)
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
    
    // MARK: - Functions
    func pauseButtonAction() {
        
        // Stop Pause Timer, reset and start again
        pauseStopwatch.stop()
        pauseStopwatch.start()
        
        // Add Set
        if numberOfSets[exerciseIndex]<8 {
            numberOfSets[exerciseIndex] += 1
            
        }
        
        // Play Sound for activation
        AudioPlayer.playSound(soundFile: "NewSet")
    }
    
    func saveWorkout() {
        if (numberOfSets[0] != 0) {
            // stop timers
            workoutStopwatch.isRunning.toggle()
            pauseStopwatch.stop()
            
            // save workout stats
            savedWorkouts.savedWorkouts.append(Workout(exercises: numberOfExercises, date: currentDate, duration: self.workoutStopwatch.elapsedTime))
            
            // show popup
            withAnimation {
                isShowPopup = true
            }
            
            // dismiss View after a few seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
    
}

// MARK: - Preview
struct WorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutView()
            .environmentObject(UserObject())
            .environmentObject(WorkoutObject())
    }
}



