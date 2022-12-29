//
//  Weight.swift
//  Fitness App
//

import Foundation

struct Entry: Identifiable, Codable {
    var id = UUID()
    let weight: Double
    let date: Date
}

class WeightObject: ObservableObject {
    @Published var savedEntries = [Entry]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(savedEntries) {
                UserDefaults.standard.set(encoded, forKey: "WeightObject")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "WeightObject") {
            if let decodedItems = try? JSONDecoder().decode([Entry].self, from: savedItems) {
                savedEntries = decodedItems
                return
            }
        }
        savedEntries = []
    }
    
    func saveEntry(value: Double) {
        savedEntries.append(Entry(weight: value, date: Date.now))
    }
}

/*
 This is NO Environment Object! It should be called like this:
 
 // Weight Object
 @ObservedObject var weightObject = WeightObject()
 
 */
