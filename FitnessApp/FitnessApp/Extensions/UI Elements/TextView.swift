//
//  TextView.swift
//  Fitnessential
//
//  Created by Leon Kling on 11.11.22.
//

import SwiftUI

struct TextView: View {
    
    var titel: String
    var bodyText: String
    var color: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Text(titel)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, -1)
            
            Rectangle()
                .frame(width: 120, height: 5)
                .foregroundColor(color ? Color.DS_Accent : Color.DS_Primary_RV)
                .padding(.bottom)
            
            Text(bodyText)
                .fontWeight(.light)
                .font(.footnote)
                .padding(.bottom, 20)
        }
    }
}

struct TextView_Previews: PreviewProvider {
    static var previews: some View {
        TextView(titel: "Test", bodyText: "Test", color: true)
    }
}
