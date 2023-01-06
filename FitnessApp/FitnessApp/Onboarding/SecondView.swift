//
//  SecondView.swift
//  Fitness App
//


import SwiftUI

struct SecondView: View {
    
    @Binding var currentView: Int
    
    var body: some View {
        ZStack {
            Color.SingleAccent
                .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                Text("Fitness App")
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding(.bottom)
                
                Spacer()
                
                Image(systemName: "bell.and.waves.left.and.right")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                    .font(.largeTitle.weight(.thin))
                    .padding()

                
                Spacer()
                
                TextView(titel: "Notifications", bodyText: "Allow us to send you notifications. These are important for your break timer or other features. We do not send messages that you do not want.", color: false)
                
                BigButton(text: "Allow", icon: "arrow.right") {
                    
                    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                        if success {
                            print("Notification Set")
                            self.currentView = 2
                        } else if let error = error {
                            print(error.localizedDescription)
                            // Needs to be deled with
                        }
                    }
                }
            }
            .padding(30)
            .preferredColorScheme(.light)
        }
    }
}

// MARK: - Preview
struct SecondView_Previews: PreviewProvider {
    static var previews: some View {
        SecondView(currentView: .constant(2))
    }
}
