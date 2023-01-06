//
//  WeightList.swift
//  Fitness App
//
//  Created by Leon Kling on 29.12.22.
//

import SwiftUI

struct WeightList: View {
    
    // User Info
    @EnvironmentObject var userObject: UserObject
    
    var body: some View {
        List {
            ForEach(userObject.props.weightEntries) { entry in
                HStack {
                    Image(systemName: "scalemass")
                    Text(entry.weight.dezimalString())
                    Spacer()
                    Text(entry.date.formatted(date: .abbreviated, time: .omitted))
                }
            }
            .onDelete(perform: removeRows)
            .listRowBackground(Color.Layer3)
        }
        .background(Color.Layer2)
        .scrollContentBackground(.hidden)
        .toolbar {
            EditButton()
        }
    }
    
    func removeRows(at offsets: IndexSet) {
        userObject.props.weightEntries.remove(atOffsets: offsets)
    }
}

struct WeightList_Previews: PreviewProvider {
    static var previews: some View {
        WeightList()
            .environmentObject(UserObject())
    }
}
