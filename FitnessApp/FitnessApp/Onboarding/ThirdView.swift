//
//  ThirdView.swift
//  Fitnessential
//

import SwiftUI

struct ThirdView: View {
    
    // View Selection
    @Binding var currentView: Int

    // User Info
    @ObservedObject var user = User()
    
    // Keyboard Focus
    @FocusState private var focusedField: Field?
    
    // Keyboard Toolbar
    enum Field {
        case age
        case height
        case weight
    }
    
    // User Metrics
    @State private var age: Int = 0
    @State private var height: Int = 0
    @State private var weight: Double = 0
    @State private var target: Int = 3
    
    // Double Formatter for user input
    let weightFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.zeroSymbol  = ""
        return formatter
    }()
    
    // Int Formatter for user input
    let ageFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        formatter.maximumIntegerDigits = 2
        formatter.zeroSymbol  = ""
        return formatter
    }()
    
    // Int Formatter for user input
    let heightFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        formatter.maximumIntegerDigits = 3
        formatter.zeroSymbol  = ""
        return formatter
    }()
    
    // MARK: - Body
    var body: some View {
        ZStack {
            Color.DS_Primary_RV
                .ignoresSafeArea(.keyboard)
            
            VStack(alignment: .leading) {
                Text("Fitness App")
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding(.bottom)
                
                Spacer()
                
                // MARK: - List
                VStack(spacing: 25) {
                    // Age
                    HStack {
                        Text("Age")
                        Spacer()
                        TextField("90", value: $age, formatter: ageFormatter)
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.trailing)
                            .font(.title3.bold())
                            .focused($focusedField, equals: .age)
                            .toolbar {
                                ToolbarItemGroup(placement: .keyboard) {
                                    Spacer()
                                    
                                    if (focusedField == .age) {
                                        
                                        Button("Next") {
                                            focusedField = .height
                                        }
                                    }
                                    else if( focusedField == .height) {
                                        Button("Next") {
                                            focusedField = .weight
                                        }
                                    }
                                    else {
                                        Button("Done") {
                                            focusedField = .none
                                        }
                                    }
                                }
                            }

                        
                    }
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(.white, lineWidth: 3)
                    )
                    
                    // Height
                    HStack {
                        Text("Height")
                        Spacer()
                        TextField("180", value: $height, formatter: heightFormatter)
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.trailing)
                            .font(.title3.bold())
                            .focused($focusedField, equals: .height)
                        
                        
                    }
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(.white, lineWidth: 3)
                    )
                    
                    // Weight
                    HStack {
                        Text("Weight")
                        Spacer()
                        TextField("80,00", value: $weight, formatter: weightFormatter)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                            .font(.title3.bold())
                            .focused($focusedField, equals: .weight)
                        
                    }
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(.white, lineWidth: 3)
                    )
                    
                    // Target
                    HStack {
                        Text("Weekly Target")
                        Spacer()
                        Text("\(target)")
                            .font(.title3.bold())
                        Spacer()
                        Button("-") { subtracTarget() }
                            .buttonStyle(.borderedProminent)
                            .tint(Color.DS_Primary)
                            .foregroundColor(Color.DS_Primary_RV)
                        Button("+") { addTarget() }
                            .buttonStyle(.borderedProminent)
                            .tint(Color.DS_Primary)
                            .foregroundColor(Color.DS_Primary_RV)
                        
                    }
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(.white, lineWidth: 3)
                    )
                    
                    Text("How many times a week do you want to go to the Gym?")
                        .font(.caption2)
                        .foregroundStyle(Color.DS_Light)
                        .padding(.top, -10)
                }

                
                Spacer()
                
                TextView(titel: "Your Stats", bodyText: "Give us some information about yourself to make it easier for you to get started.", color: true)
                
                MainButton(text: "Save", icon: "arrow.right") {
                    if ( isValidReply() ) {
                        
                        self.currentView = 3
                        
                        // Save user Data
                        user.age = age
                        user.height = height
                        user.weight = weight
                        user.target = target
                        
                    }
                    else {
                        // User Feedback
                        print("Not Valid")
                    }
                    
                }
            }
            .padding(30)
            .preferredColorScheme(.dark)
            .ignoresSafeArea(.keyboard)

        }
    }
    
    private func addTarget() {
        if (target < 7) {
            target += 1
        }
    }
    
    private func subtracTarget() {
        if (target > 1) {
            target -= 1
        }
    }
    
    private func isValidReply() -> Bool {
        if (Double(age).isZero && Double(height).isZero && weight.isZero) {
            return false
        }
        else {
            return true
        }
    }
}

struct ThirdView_Previews: PreviewProvider {
    static var previews: some View {
        ThirdView(currentView: .constant(3))
    }
}



