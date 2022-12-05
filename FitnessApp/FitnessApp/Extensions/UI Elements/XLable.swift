//
//  XLable.swift
//  Fitnessential
//
//  Created by Leon Kling on 05.12.22.
//

import SwiftUI

struct XLable: View {
    
    let tint: Color
    let back: Color
    
    var body: some View {
        Image(systemName: "xmark")
            .padding(10)
            .bold()
            .foregroundColor(tint)
            .background(back)
            .cornerRadius(40)
    }
}

struct XLable_Previews: PreviewProvider {
    static var previews: some View {
        XLable(tint: Color.red, back: Color.DSOverlay)
    }
}
