//
//  StreakView.swift
//  GetMoving
//
//  Created by Leon Kling on 04.10.22.
//

import SwiftUI

struct StreakView: View {
    var body: some View {
        HStack {
            Spacer()
            Text("Placeholder")
                .foregroundColor(.gray)
                .frame(height: 150)
            Spacer()
        }
        .background(Material.regular)
        .cornerRadius(20)
    }
}

struct StreakView_Previews: PreviewProvider {
    static var previews: some View {
        StreakView()
    }
}
