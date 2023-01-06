//
//  FirstView.swift
//  Fitness App
//


import SwiftUI

struct FirstView: View {
    
    @Binding var currentView: Int
    
    var body: some View {
        ZStack {
            
            Image("Background")
                .resizable()
            
            VStack(alignment: .leading){
                Text("Fitness App")
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding(.bottom)
                
                Spacer()
                
                Text("DON’T SIT AT HOME. GO GYM!")
                    .font(.system(size: 90))
                    .fontWeight(.bold)
                    .padding(.bottom)
                    .truncationMode(.middle)
                
                Spacer()
                
                BigButton(text: "Let’s Begin", icon: "arrow.right") {
                    self.currentView = 1
                }
            }
            .padding(30)
        }
        .preferredColorScheme(.light)
    }
}

// MARK: - Preview
struct FirstView_Previews: PreviewProvider {
    static var previews: some View {
        FirstView(currentView: .constant(1))
    }
}
