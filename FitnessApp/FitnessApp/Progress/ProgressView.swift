//
//  ProgressView.swift
//  Fitness App
//

import SwiftUI

struct ProgressView: View {
    
    // Saved Workouts
    @EnvironmentObject var userObject: UserObject
    
    // MARK: - Body
    var body: some View {
        
        if(userObject.props.workouts.isEmpty) {
            EmptyListView()
                .navigationTitle("Progress")
        } else {
            List {
                ForEach(userObject.props.workouts) { entry in
                    ProgressRow(
                        date: entry.date.formatted(date: .abbreviated, time: .omitted),
                        exercises: entry.exercises,
                        time: entry.duration.timeString().minutes,
                        day: entry.date.formatted(.dateTime.weekday(.short)),
                        weekNumber: String(Calendar.current.component(.weekOfYear, from: entry.date))
                    )
                }
                .onDelete(perform: removeRows)
                .listRowBackground(Color.Layer3)
            }
            .navigationTitle("Progress")
            .background(Color.Layer1)
            .scrollContentBackground(.hidden)

        }
    }
    // MARK: - Functions
    
    func removeRows(at offsets: IndexSet) {
        userObject.props.workouts.remove(atOffsets: offsets)
    }
        
}

// MARK: - Empty List View
struct EmptyListView: View {
    var body: some View {
        VStack {
            Image(systemName: "eyes")
                .foregroundColor(Color.SingleLight)
                .font(.title)
            Text("No workouts yet")
                .padding()
                .foregroundColor(Color.SingleLight)
                .font(.title2)
        }
    }
}



// MARK: - Preview
struct ProgressView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressView()
            .environmentObject(UserObject())
    }
}
