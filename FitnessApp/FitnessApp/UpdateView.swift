//
//  UpdateView.swift
//  Fitness App
//

import SwiftUI

struct UpdateView: View {
    
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack{
            Spacer()
            
            VStack {
                Text("Whats new")
                Text("in Fitness App")
            }
            .font(.largeTitle.weight(.bold))
            .padding(.top)
            
            
            VStack(alignment: .leading) {
                FeatureRow(image: "photo.circle.fill", title: "New App Icon", text: "A new App icon was added")
        
                FeatureRow(image: "list.bullet.circle", title: "Progress View", text: "The progress view was updated to show more info")
        
                FeatureRow(image: "bell.badge.circle", title: "New Sounds", text: "You can now change the pause timer sound")
                
                FeatureRow(image: "gearshape.circle", title: "Workout Settings", text: "More settings ware added, like include stretching or warmup")
                
                FeatureRow(image: "ant.circle", title: "Lots of Bug fixes", text: "Most notable are notification fixes and design changes")
                
            }
            Spacer()
            
            MainButton(text: "OK") {
                isPresented = false
            }
            .padding()
            
            Spacer()
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
