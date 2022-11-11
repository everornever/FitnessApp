//
//  FourthView.swift
//  Fitnessential
//
//  Created by Leon Kling on 10.11.22.
//

import SwiftUI

struct FourthView: View {
    
    @Binding var showOnboarding: Bool

    
    var body: some View {
        ZStack {
            Color.DS_Accent
                .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                Text("Fitness App")
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding(.bottom)
                
                Spacer()
                
                Image(systemName: "checkmark.seal")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                    .font(.largeTitle.weight(.thin))
                    .padding()

                
                Spacer()
                
                TextView(titel: "Thank you!", bodyText: "Thank you for trying the Fitness App. We hope that you like it. This app is still under development. We will be happy if you give us feedback.", color: false)
                
                MainButton(text: "OK, Got it!") {
                    showOnboarding.toggle()
                    //user.firstStart = false
                }
            }
            .padding(30)
            .preferredColorScheme(.light)
        }
    }
}

struct FourthView_Previews: PreviewProvider {
    static var previews: some View {
        FourthView(showOnboarding: .constant(true))
    }
}
