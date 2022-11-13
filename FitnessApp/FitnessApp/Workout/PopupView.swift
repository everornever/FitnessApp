//
//  PopupView.swift
//  GetMoving
//
//  Created by Leon Kling on 11.09.22.
//

import SwiftUI

struct PopupView: View {
    var body: some View {
        VStack {
            Image(systemName: "checkmark")
                .foregroundColor(.green)
                .font(.system(size: 60))
                .padding()
            Text("Workout")
                .font(.title)
            Text("saved")
                .font(.title)
        }
        .padding(50)
        .background(.ultraThinMaterial)
        .cornerRadius(10)
    }
}

struct PopupView_Previews: PreviewProvider {
    static var previews: some View {
        PopupView()
    }
}
