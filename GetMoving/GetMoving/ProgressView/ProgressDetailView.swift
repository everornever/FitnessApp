//
//  ProgressDetailView.swift
//  GetMoving
//
//  Created by Leon Kling on 22.09.22.
//

import SwiftUI

struct ProgressDetailView: View {
    
    // for the SheetView Dismiss
    @Environment(\.dismiss) var dismiss
    
    let date: String
    
    var body: some View {
        Text("Workout from: \(date)")
        Button("Dismiss") {
            dismiss()
        }
    }
}

struct ProgressDetailView_Previews: PreviewProvider {
    
    static let current = "some Date"
    
    static var previews: some View {
        ProgressDetailView(date: current)
    }
}
