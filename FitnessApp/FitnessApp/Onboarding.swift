//
//  Onboarding.swift
//  Fitnessential
//
//  Created by Leon Kling on 04.11.22.
//


// TODO: Make lastApp Version to current, set firstStart false


import SwiftUI

struct FirstView: View {
    var body: some View {
        VStack {
            Rectangle()
                .foregroundColor(.gray)
                .frame(width: 400, height: 400)
                .padding()
            
            Text("Quick & Easy")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom)
            
            Text("Kein Login oder langen workout plan erstellen. Du kannst einfach loslegen. **FitnessApp** ist dein minimalistischer GYM Bro.")
                .fontWeight(.light)
                .padding()
            
            Spacer()
        }
    }
}

struct SecondView: View {
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

struct Onboarding: View {
    
    @Binding var showOnboarding: Bool
    
    @State private var currentTab = 0
    
    var body: some View {
        TabView(selection: $currentTab,
        content:  {
            FirstView()
                                .tag(0)
            SecondView()
                                .tag(1)
            ThirdView(showOnboarding: $showOnboarding)
                                .tag(2)
                        })
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
    }
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding(showOnboarding: .constant(true))
    }
}
