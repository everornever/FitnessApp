//
//  UpdateView.swift
//  Fitness App
//

import SwiftUI

struct UpdateView: View {
    
    @Binding var isPresented: Bool
    
    // User Info
    @ObservedObject var user = User()
    
    // App Version
    let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "No version"
    
    var body: some View {
        VStack{
            
            VStack {
                Text("Whats new")
                Text("in Fitness App")
            }
            .font(.largeTitle.weight(.bold))
            .padding(.top, 40)
            
            Text("Version \(appVersion)")
                .foregroundColor(Color.DSLight)
            
            Spacer()
            
            VStack(alignment: .leading) {
        
                FeatureRow(image: "list.bullet.circle", title: "New Target View V1", text: "Get details over your last workouts and see how you performed")
                
                FeatureRow(image: "ant.circle", title: "Bug fixes", text: "Fixed notification sound bug, Update View")
                
            }
            
            Spacer()
            
            MainButton(text: "OK") {
                isPresented = false
                user.lastVersion = appVersion
            }
            .padding()
            
        }
    }
}

struct UpdateView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateView(isPresented: .constant(true))
    }
}

struct FeatureRow: View {
    
    let image: String
    let title: String
    let text: String
    
    var body: some View {
        HStack {
            Image(systemName: image)
                .font(.largeTitle)
                .frame(width: 30)
                .padding()
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.title3)
                    .bold()
                
                Text(text)
                    .font(.body)
                    .foregroundColor(Color.DSLight)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding(10)
    }
}
