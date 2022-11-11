//
//  FirstView.swift
//  Fitnessential
//
//  Created by Leon Kling on 09.11.22.
//

import SwiftUI

struct FirstView: View {
    
    @Binding var tabSelection: Int
    
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
                
                MainButton(text: "Let’s Begin", icon: "arrow.right") {
                    self.tabSelection = 1
                }
            }
            .padding(30)
        }
        .preferredColorScheme(.light)
    }
}

struct FirstView_Previews: PreviewProvider {
    static var previews: some View {
        FirstView(tabSelection: .constant(1))
    }
}
