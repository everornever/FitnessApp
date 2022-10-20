//
//  WeightView.swift
//  GetMoving
//
//  Created by Leon Kling on 19.10.22.
//

import SwiftUI

struct WeightView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var user = User()
    
    var body: some View {
        VStack {
            Rectangle()
                .frame(width: 50, height: 5)
                .cornerRadius(20)
                .foregroundStyle(.secondary)
                .padding()
            Spacer()
            VStack {
                Text("Was ist dein Gewicht ?")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                
                HStack {
                    TextField("Trage dein Gewicht ein", value: $user.weight, format: .number)
                        .lineLimit(1)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.decimalPad)
                        .frame(width: 150)
                    
                    Text("KG")
                        .fontWeight(.bold)
                        .font(.body)
                }
                
                Button("Save") {
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
            }
            Spacer()
        }
    }
}

struct WeightView_Previews: PreviewProvider {
    static var previews: some View {
        WeightView()
    }
}


