//
//  SoundList.swift
//  Fitness App
//

import SwiftUI

struct SoundListView: View {
    var body: some View {
        List {
            Section("Click to listen to sound") {
                Text("Sound 1")
            }
        }
        .background(Color.DSOverlay)
        .scrollContentBackground(.hidden)
    }
}

struct SoundListView_Previews: PreviewProvider {
    static var previews: some View {
        SoundListView()
    }
}
