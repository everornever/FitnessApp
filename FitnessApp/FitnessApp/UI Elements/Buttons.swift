//
//  RoundButton.swift
//  Fitness App
//

import SwiftUI

struct CancelButton: View {
    var clicked: (() -> Void)
    var body: some View {
        Button(action: clicked) {
            Image(systemName: "xmark.circle.fill")
                .font(.title)
                .imageScale(.large)
                .foregroundColor(.SingleLight)
                .symbolRenderingMode(.hierarchical)
        }
    }
}

struct CheckButton: View {
    var clicked: (() -> Void)
    var body: some View {
        Button(action: clicked) {
            Image(systemName: "checkmark.circle.fill")
                .font(.title)
                .imageScale(.large)
                .symbolRenderingMode(.palette)
                .foregroundStyle(Color.black, Color.SingleAccent)
        }
    }
}

struct BigButton: View {
    
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
            .foregroundColor((tint != nil) ? Color.primary : Color.PrimaryReversed)
            .background((tint != nil) ? tint : Color.primary)
            .cornerRadius(20)
        }
    }
}

struct MainLabel: View {
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
        .foregroundColor((tint != nil) ? Color.primary : Color.PrimaryReversed)
        .background((tint != nil) ? tint : Color.primary)
        .cornerRadius(20)
    }
}




// MARK: - Preview
struct Button_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 50) {
            CancelButton() { }
            CheckButton() { }
            BigButton(text: "Test", icon: "arrow.forward", tint: .primary) { }
        }
    }
}


