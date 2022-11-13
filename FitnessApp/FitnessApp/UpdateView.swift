//
//  UpdateView.swift
//  Fitnessential
//
//  Created by Leon Kling on 04.11.22.
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
            
            
            HStack {
                Image(systemName: "lanyardcard.fill")
                    .font(.title)
                    .frame(width: 40)
                    .padding()
                
                VStack(alignment: .leading) {
                    Text("Dark Mode")
                        .font(.title3.weight(.bold))
                    
                    Text("Support for dark mode was added with a updated Color concept ")
                        .font(.body)
                        .foregroundColor(Color.DS_Light)
                }
            }
            .padding()
            
            HStack {
                Image(systemName: "filemenu.and.selection")
                    .font(.title)
                    .frame(width: 40)
                    .padding()
                
                VStack(alignment: .leading) {
                    Text("New Dashboard")
                        .font(.title3.weight(.bold))
                    
                    Text("Updated design conzept. Some features are unfinished and still in progress")
                        .font(.body)
                        .foregroundColor(Color.DS_Light)
                }
            }
            .padding()
            
            HStack {
                Image(systemName: "figure.run.circle")
                    .font(.title)
                    .frame(width: 40)
                    .padding()
                
                VStack(alignment: .leading) {
                    Text("Warm up")
                        .font(.title3.weight(.bold))
                    
                    Text("You can now add a warm up inside your workout. This not affect any Set progress")
                        .font(.body)
                        .foregroundColor(Color.DS_Light)
                }
            }
            .padding()
            
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
