//
//  ExerciseListView.swift
//  GetMoving
//
//  Created by Leon Kling on 20.10.22.
//

import SwiftUI

struct ExerciseListView: View {
    
    @StateObject var exercises = SavedExercises()
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            List {
                ForEach(exercises.savedExercises.indices, id: \.self) { index in
                    Section {
                        HStack {
                            TextField("Name", text: $exercises.savedExercises[index].name)
                                .lineLimit(1)
                            Spacer()
                            Text("\(exercises.savedExercises[index].kilo.formatted()) KG")
                                .fontWeight(.bold)
                                .padding(.trailing)
                            Button("+") { addWeight(index: index) }
                                .buttonStyle(.borderedProminent)
                            Button("-") { subtractWeight(index: index) }
                                .buttonStyle(.borderedProminent)
                        }
                        .padding(3)
                    }
                }
                .onDelete(perform: removeRows)
                .onMove(perform: move)
                
                HStack {
                    Image(systemName: "plus.circle")
                        .foregroundColor(.accentColor)
                    Button("Ubung hinzufugen") { addExersice() }
                }
                    
            }
            .navigationBarTitle("Notizen", displayMode: .inline)
            .toolbar {
                EditButton()
            }
        }
    }
    
    // MARK: - Functions
    
    func removeRows(at offsets: IndexSet) {
        exercises.savedExercises.remove(atOffsets: offsets)
    }
    
    func move(from source: IndexSet, to destination: Int) {
        exercises.savedExercises.move(fromOffsets: source, toOffset: destination)
    }
    
    func addExersice() {
        exercises.savedExercises.append(Exercise(name: "???", kilo: 10.0))
    }
    
    func addWeight(index: Int) {
        exercises.savedExercises[index].kilo += 2.5
    }
    
    func subtractWeight(index: Int) {
        exercises.savedExercises[index].kilo -= 2.5
    }
    
}

// MARK: - Preview
struct ExerciseListView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseListView()
    }
}
