//
//  ThirdView.swift
//  Fitnessential
//
//  Created by Leon Kling on 09.11.22.
//

import SwiftUI

struct ThirdView: View {
    
    @ObservedObject var user = User()
    @Binding var showOnboarding: Bool
    let appVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
    
    var body: some View {
        VStack {
            Rectangle()
                .foregroundColor(.gray)
                .frame(width: 400, height: 400)
                .padding()
            
            Text("Danke")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom)
            
            Text("Danke das du **FitnessApp** ausprobierst. Wir hoffen es wird dir gefallen.")
                .fontWeight(.light)
                .padding()
            
            Button("Fertig") {
            showOnboarding.toggle()
            }
            .buttonStyle(.borderedProminent)
            
            Spacer()
        }
    }
}

struct ThirdView_Previews: PreviewProvider {
    static var previews: some View {
        ThirdView( showOnboarding: .constant(false))
    }
}
