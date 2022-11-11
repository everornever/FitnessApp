//
//  Onboarding.swift
//  Fitnessential
//
//  Created by Leon Kling on 04.11.22.
//

import SwiftUI

struct Onboarding: View {
    
    @Binding var showOnboarding: Bool
    
    @State private var currentTab = 0
    
    var body: some View {
        NavigationView {
            
            switch currentTab {
            case 1:
                SecondView(tabSelection: $currentTab)
            case 2:
                ThirdView(tabSelection: $currentTab)
            case 3:
                FourthView(showOnboarding: $showOnboarding)
            default:
                FirstView(tabSelection: $currentTab)
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
