//
//  ExerciseListView.swift
//  GetMoving
//
//  Created by Leon Kling on 20.10.22.
//

import SwiftUI

struct ItemView: View {
    
    @Binding var stepper: Double
    @State var name: String
    @State var kilo: Double
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(name)
            Divider()
            HStack {
                Image(systemName: "dumbbell.fill")
                Text("\(kilo) KG")
                    .fontWeight(.bold)
                    .font(.title2)
                Spacer()
                Stepper("", value: $stepper, step: 0.5)
            }
        }
    }
}

struct ExerciseListView: View {
    
    @StateObject var exercises = SavedExercises()
    
    var body: some View {
        VStack {
            Rectangle()
                .frame(width: 50, height: 5)
                .cornerRadius(20)
                .foregroundStyle(.secondary)
                .padding()
            
            List {
                ForEach(exercises.savedExercises) { index in
                    Section {
                        ItemView(stepper: $exercises.savedExercises[0].kilo, name: index.name, kilo: index.kilo)
                    }
                }
                .onDelete(perform: removeRows)
                
                Section {
                    Button("Add Exercise") {
                        
                    }
                }
            }
        }
        
    }
    
    func removeRows(at offsets: IndexSet) {
        exercises.savedExercises.remove(atOffsets: offsets)
    }
}

struct ExerciseListView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseListView()
    }
}
