//
//  MainButton.swift
//  Fitnessential
//
//  Created by Leon Kling on 09.11.22.
//

import SwiftUI

struct MainButton: View {
    
    var text: String?
    var icon: String?
    var tint: Color?
    var clicked: (() -> Void) /// use closure for callback
    
    var body: some View {
        Button(action: clicked) { /// call the closure here
            HStack {
                if(text != nil) {
                    Text(text!) /// your text
                        .font(.headline)
                        .fontWeight(.bold)
                }
                
                if(icon != nil) {
                    Image(systemName: icon!)
                        .font(.headline)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(20)
            .foregroundColor((tint != nil) ? Color.DSPrimary : Color.DSPrimary_RV)
            .background((tint != nil) ? tint : Color.DSPrimary)
            .cornerRadius(20)
        }
    }
}

struct MainLable: View {
    var text: String?
    var icon: String?
    var tint: Color?
    
    var body: some View {
        HStack {
            if(text != nil) {
                Text(text!) /// your text
                    .font(.headline)
                    .fontWeight(.bold)
            }
            
            if(icon != nil) {
                Image(systemName: icon!)
                    .font(.headline)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(20)
        .foregroundColor((tint != nil) ? Color.DSPrimary : Color.DSPrimary_RV)
        .background((tint != nil) ? tint : Color.DSPrimary)
        .cornerRadius(20)
    }
}

struct MainButton_Previews: PreviewProvider {
    static var previews: some View {
        MainButton(text: "Test") { }
    }
}
