//
//  ExerciseListView.swift
//  Fitness App
//

import SwiftUI

struct ExerciseListView: View {
    
    // User Info
    @EnvironmentObject var userObject: UserObject
    
    @Binding var isPresented: Bool
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            List {
                ForEach(userObject.props.exerciseNotes.indices, id: \.self) { index in
                    Section {
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
                        .padding(3)
                    }
                    .listRowBackground(Color.Layer3)
                }
                .onDelete(perform: removeRows)
                .onMove(perform: move)
                
                HStack {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(.accentColor)
                    Button("Add exercise") { addExercise() }
                }
                .listRowBackground(Color.Layer3)
                    
            }
            .navigationBarTitle("Notes", displayMode: .inline)
            .background(Color.Layer2)
            .scrollContentBackground(.hidden)
            .toolbar {
                CancelButton() {
                    isPresented = false 
                }
            }
        }
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
        ExerciseListView(isPresented: .constant(true))
            .environmentObject(UserObject())
    }
}
