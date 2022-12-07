//
//  PopupView.swift
//  Fitness App
//

import SwiftUI

struct PopupView: View {
    var body: some View {
        VStack {
            Image(systemName: "checkmark")
                .foregroundColor(Color.DSAccent)
                .font(.system(size: 60))
                .padding()
            Text("Workout saved")
                .font(.title)
        }
        .padding(50)
        .background(Color.DSOverlay)
        .cornerRadius(10)
    }
}

struct PopupView_Previews: PreviewProvider {
    static var previews: some View {
        PopupView()
    }
}
