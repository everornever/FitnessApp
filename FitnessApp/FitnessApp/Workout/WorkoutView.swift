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
    @EnvironmentObject var userObject: UserObject
    
    // View toggles
    @State private var endWorkoutAlert = false
    @State private var isShowPopup: Bool = false
    
    // Workout Duration Timer
    @StateObject var durationTimer = DurationTimerObject()
    
    // Rest Timer
    @StateObject var restTimer = RestTimerObject()
    
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
            
            Color.Layer1
                .ignoresSafeArea()
            
            VStack {
                Text(durationTimer.elapsedTime.timeString().hours)
                    .monospacedDigit()
                    .font(.title2)
                    .fontWeight(.bold)
                
                // MARK: - Exercise List
                List {
                    
                    if (userObject.props.includeStretching) {
                        Section("Press to Check") {
                            HStack {
                                Image(systemName: "figure.strengthtraining.functional")
                                    .font(.title3)
                                
                                Text("Stretching")
                                
                                Spacer()
                                
                                if (stretching) {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(Color.SingleAccent)
                                        .font(.title3)
                                }
                                else {
                                    Image(systemName: "circlebadge")
                                        .foregroundColor(Color.primary)
                                        .font(.title2)
                                }
                            }
                            .listRowBackground(Color.Layer3)
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
                                        .foregroundColor(Color.SingleAccent)
                                }
                                
                                Text("\(index+1). Exercise")
                                
                                Spacer()
                                
                                if(numberOfSets[index] < 5) {
                                    ForEach(0..<numberOfSets[index], id: \.self) { _ in
                                        
                                        Image(systemName: "circlebadge.fill")
                                            .foregroundColor(Color.SingleAccent)
                                            .font(.title)
                                        
                                    }
                                } else {
                                    Image(systemName: "\(numberOfSets[index]).circle")
                                        .foregroundColor(Color.SingleAccent)
                                        .font(.title)
                                }
                                
                            }
                            .listRowBackground(Color.Layer3)
                            
                        }
                    }
                    
                    if (userObject.props.includeWarmup) {
                        Section("Press to Check") {
                            HStack {
                                Image(systemName: "figure.run")
                                    .font(.title3)
                                
                                Text("Warm Up")
                                
                                Spacer()
                                
                                if (warmUp) {
                                    Image(systemName: "circlebadge.fill")
                                        .foregroundColor(Color.SingleAccent)
                                        .font(.title)
                                }
                                else {
                                    Image(systemName: "circlebadge")
                                        .foregroundColor(Color.primary)
                                        .font(.title)
                                }
                            }
                            .listRowBackground(Color.Layer3)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                warmUp.toggle()
                            }
                        }
                    }
                    
                }
                .background(Color.Layer2)
                .scrollContentBackground(.hidden)
                .scrollIndicators(.hidden)
                .cornerRadius(30)
                .padding([.leading, .trailing], 20)
                .shadow(color: Color.gray.opacity(0.1), radius: 10, x: 0, y: 0)

                // MARK: - Rest Button
                VStack {
                    HStack {
                        Text(restTimer.timeLeft.timeString().seconds)
                            .font(.title)
                            .fontWeight(.semibold)
                            .monospacedDigit()
                        
                        Button {
                            restTimer.stop()
                        } label: {
                            Image(systemName: "gobackward")
                                .tint(Color.SingleLight)
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
                                .foregroundStyle(Color.primary)
                        }
                        
                        
                        // Rest Button
                        Button {
                            pauseButtonAction()
                        }  label: {
                            Image(systemName: "pause.fill")
                                .font(.largeTitle)
                                .foregroundColor(.black)
                                .padding(30)
                        }
                        .tint(Color.SingleAccent)
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
                                .foregroundStyle(Color.primary)
                        }
                    }
                }
                .padding(.bottom)
                
                Spacer()
                
                // MARK: - Notes
                BigButton(text: "", icon: "list.bullet.clipboard", tint: Color.Layer2) { showingNotes = true }
                    .padding([.leading, .trailing], 20)
                    .sheet(isPresented: $showingNotes) {
                        ExerciseListView(isPresented: $showingNotes)
                    }
            
            }
            // MARK: - Navigation Bar
            .navigationBarTitle("Workout", displayMode: .inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: CancelButton() { endWorkoutAlert = true } )
            .navigationBarItems(trailing: CheckButton() { saveWorkout() } )
            .alert("Quit Workout", isPresented: $endWorkoutAlert) {
                Button("Resume", role: .cancel) {}
                    .tint(Color.SingleAccent)
                Button("Quit", role: .destructive) {
                    restTimer.stop()
                    durationTimer.stop()
                    presentationMode.wrappedValue.dismiss()
                }
            } message: {
                Text("Are you sure you want to quit your current workout?")
            }
            
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
            durationTimer.start()
        }
    }
    
    // MARK: - Functions
    func pauseButtonAction() {
        
        // Stop Pause Timer, reset and start again
        restTimer.stop()
        restTimer.start()
        
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
            durationTimer.stop()
            restTimer.stop()
            
            // save workout stats
            userObject.props.workouts.append(Workout(exercises: numberOfExercises, date: currentDate, duration: self.durationTimer.elapsedTime))
            
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
    }
}



