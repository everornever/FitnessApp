//
//  MainButton.swift
//  Fitnessential
//
//  Created by Leon Kling on 09.11.22.
//

import SwiftUI

struct MainButton: View {
    
    var text: String
    var icon: String?
    var clicked: (() -> Void) /// use closure for callback
    
    var body: some View {
        Button(action: clicked) { /// call the closure here
            HStack {
                Text(text) /// your text
                    .font(.headline)
                    .fontWeight(.bold)
                
                if(icon != nil) {
                    Image(systemName: icon!)
                        .font(.headline)
                }
            }
            .frame(minWidth: 300)
            .padding(20)
            .foregroundColor(Color.DS_Primary_RV)
            .background(Color.DS_Primary)
            .cornerRadius(20)
        }
    }
}

struct MainButton_Previews: PreviewProvider {
    static var previews: some View {
        MainButton(text: "Test") { }
    }
}
