//
//  PopupView.swift
//  Fitness App
//

import SwiftUI

struct PopupView: View {
    var body: some View {
        VStack {
            Image(systemName: "checkmark")
                .foregroundColor(Color.SingleAccent)
                .font(.system(size: 60))
                .padding()
            Text("Workout saved")
                .font(.title)
        }
        .padding(50)
        .background(Material.thin)
        .cornerRadius(10)
    }
}

// MARK: - Preview
struct PopupView_Previews: PreviewProvider {
    static var previews: some View {
        PopupView()
    }
}
