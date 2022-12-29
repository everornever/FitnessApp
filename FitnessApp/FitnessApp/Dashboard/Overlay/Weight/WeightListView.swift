//
//  WeightList.swift
//  Fitness App
//
//  Created by Leon Kling on 29.12.22.
//

import SwiftUI

struct WeightList: View {
    
    // Weight Object
    @ObservedObject var weightObject = WeightObject()
    
    var body: some View {
        List {
            ForEach(weightObject.savedEntries) { entry in
                HStack {
                    Image(systemName: "scalemass")
                    Text(entry.weight.dezimalString())
                    Spacer()
                    Text(entry.date.formatted(date: .abbreviated, time: .omitted))
                }
            }
            .onDelete(perform: removeRows)
            .listRowBackground(Color.DSSecondaryOverlay)
        }
        .background(Color.DSSecondaryBackground)
        .scrollContentBackground(.hidden)
        .toolbar {
            EditButton()
        }
    }
    
    func removeRows(at offsets: IndexSet) {
        weightObject.savedEntries.remove(atOffsets: offsets)
    }
}

struct WeightList_Previews: PreviewProvider {
    static var previews: some View {
        WeightList()
    }
}
