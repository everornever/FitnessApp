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
        TabView(selection: $currentTab,
        content:  {
            FirstView(tabSelection: $currentTab)
                                .tag(0)
            SecondView(tabSelection: $currentTab)
                                .tag(1)
            ThirdView(showOnboarding: $showOnboarding)
                                .tag(2)
                        })
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .edgesIgnoringSafeArea(.all)
    }
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding(showOnboarding: .constant(true))
    }
}
