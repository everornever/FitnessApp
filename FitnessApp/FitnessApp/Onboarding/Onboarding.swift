//
//  Onboarding.swift
//  Fitness App
//

import SwiftUI

struct Onboarding: View {
    
    @Binding var showOnboarding: Bool
    
    @State private var currentView = 0
    
    var body: some View {
        NavigationStack {
            
            switch currentView {
            case 1:
                SecondView(currentView: $currentView)
            case 2:
                ThirdView(currentView: $currentView)
            case 3:
                FourthView(showOnboarding: $showOnboarding)
            default:
                FirstView(currentView: $currentView)
            }
            
        }
        .navigationBarBackButtonHidden(true)

        
    }
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding(showOnboarding: .constant(true))
    }
}
