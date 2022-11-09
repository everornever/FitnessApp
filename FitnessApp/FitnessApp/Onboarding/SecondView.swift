//
//  SecondView.swift
//  Fitnessential
//
//  Created by Leon Kling on 09.11.22.
//

import SwiftUI

struct SecondView: View {
    
    @Binding var tabSelection: Int
    
    var body: some View {
        VStack {
            Rectangle()
                .foregroundColor(.gray)
                .frame(width: 400, height: 400)
                .padding()
            
            Text("Mitteilungen")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom)
            
            Text("Wir brauchen deine Erlaubnis, das wir dir Mitteilungen senden dürfen. Diese brauchen wir um dir z.b. zu zeigen das dein Pausen Timer abgelaufen ist.")
                .fontWeight(.light)
                .padding()
            
            Button("Erlaube Mitteilungen") {
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        print("All set!")
                        self.tabSelection = 2
                    } else if let error = error {
                        print(error.localizedDescription)
                    }
                }
            }
            .buttonStyle(.borderedProminent)
            
            Spacer()
        }
    }
}

struct SecondView_Previews: PreviewProvider {
    static var previews: some View {
        SecondView(tabSelection: .constant(2))
    }
}
