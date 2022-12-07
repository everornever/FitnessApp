//
//  XLable.swift
//  Fitness App
//

import SwiftUI

struct RoundButton: View {
    
    let tint: Color
    let back: Color
    let cancel: Bool
    
    var body: some View {
        Image(systemName: cancel ? "xmark" : "checkmark")
            .padding(10)
            .bold()
            .foregroundColor(tint)
            .background(back)
            .cornerRadius(40)
    }
}

struct RoundButton_Previews: PreviewProvider {
    static var previews: some View {
        RoundButton(tint: Color.red, back: Color.DSOverlay, cancel: false)
    }
}
