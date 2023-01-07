//
//  ExerciseNotesView.swift
//  Fitness App
//

import SwiftUI

struct ExerciseNotesView: View {
    
    // User Info
    @EnvironmentObject var userObject: UserObject
    
    @Binding var isPresented: Bool
    
    // MARK: - Body
    var body: some View {
        VStack {
            // MARK: - Top
            HStack {
                Text("Weekly Target")
                    .font(.title)
                    .bold()
                
                Spacer()
                
                CancelButton() {
                    isPresented.toggle()
                }
            }
            .padding(.horizontal, 20)
            
            Form {
                ForEach(userObject.props.exerciseNotes.indices, id: \.self) { index in
                    
                    HStack {
                        
                        TextField("Name", text: $userObject.props.exerciseNotes[index].name)
                            .lineLimit(1)
                        
                        Spacer()
                        
                        Text("\(userObject.props.exerciseNotes[index].kilos.formatted()) KG")
                            .fontWeight(.bold)
                            .padding(.trailing)
                        
                        Button("+") { addWeight(index: index) }
                            .buttonStyle(.borderedProminent)
                            .foregroundColor(Color.PrimaryReversed)
                        
                        Button("-") { subtractWeight(index: index) }
                            .buttonStyle(.borderedProminent)
                            .foregroundColor(Color.PrimaryReversed)
                        
                    }
                    .listRowBackground(Color.Layer3)
                }
                .onDelete(perform: removeRows)
                .onMove(perform: move)

                Section {
                    Button() { addExercise() } label: {
                        Label("Add exercise", systemImage: "plus.circle.fill")
                    }
                }
                .listRowBackground(Color.Layer3)
            }
            .scrollContentBackground(.hidden)
        }
        .background(Color.Layer2)
    }
    
    // MARK: - Functions
    
    func removeRows(at offsets: IndexSet) {
        userObject.props.exerciseNotes.remove(atOffsets: offsets)
    }
    
    func move(from source: IndexSet, to destination: Int) {
        userObject.props.exerciseNotes.move(fromOffsets: source, toOffset: destination)
    }
    
    func addExercise() {
        userObject.props.exerciseNotes.append(ExerciseNote(name: "???", kilos: 10.0))
    }
    
    func addWeight(index: Int) {
        if (userObject.props.exerciseNotes[index].kilos < 500) {
            userObject.props.exerciseNotes[index].kilos += 2.5
        }
    }
    
    func subtractWeight(index: Int) {
        if (userObject.props.exerciseNotes[index].kilos > 0) {
            userObject.props.exerciseNotes[index].kilos -= 2.5
        }
    }
    
}

// MARK: - Preview
struct ExerciseListView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseNotesView(isPresented: .constant(true))
            .environmentObject(UserObject())
    }
}
