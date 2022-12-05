//
//  ExerciseListView.swift
//  Fitness App
//

import SwiftUI

struct ExerciseListView: View {
    
    @StateObject private var exercises = SavedExercises()
    
    @Binding var isPresented: Bool
    
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
                                .foregroundColor(Color.DS_Primary_RV)
                            Button("-") { subtractWeight(index: index) }
                                .buttonStyle(.borderedProminent)
                                .foregroundColor(Color.DS_Primary_RV)
                        }
                        .padding(3)
                    }
                }
                .onDelete(perform: removeRows)
                .onMove(perform: move)
                
                HStack {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(.accentColor)
                    Button("Add exercise") { addExersice() }
                }
                    
            }
            .navigationBarTitle("Notes", displayMode: .inline)
            .background(Color.DSOverlay)
            .scrollContentBackground(.hidden)
            .toolbar {
                Button("Done") { isPresented = false }
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
        if (exercises.savedExercises[index].kilo < 500) {
            exercises.savedExercises[index].kilo += 2.5
        }
    }
    
    func subtractWeight(index: Int) {
        if (exercises.savedExercises[index].kilo > 0) {
            exercises.savedExercises[index].kilo -= 2.5
        }
    }
    
}

// MARK: - Preview
struct ExerciseListView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseListView(isPresented: .constant(true))
    }
}
