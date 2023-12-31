//
//  Flowers.swift
//  FlowerDetector
//
//  Created by Joan Wilson Oliveira on 15/05/23.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let flowersData = try? JSONDecoder().decode(FlowersData.self, from: jsonData)

import Foundation

// MARK: - FlowersData
struct FlowersData: Codable {
    let flowers: [Flower]
}

// MARK: - Flower
struct Flower: Codable, Hashable {
    let name, namePortuguese, scientificName, description: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(namePortuguese)
        hasher.combine(scientificName)
        hasher.combine(description)
    }
    
    static func == (lhs: Flower, rhs: Flower) -> Bool {
        return lhs.name == rhs.name &&
        lhs.namePortuguese == rhs.namePortuguese &&
        lhs.scientificName == rhs.scientificName &&
        lhs.description == rhs.description
    }
}

struct FlowerIterator: IteratorProtocol {
    private let flowers: [Flower]
    private var currentIndex = 0
    
    init(flowers: [Flower]) {
        self.flowers = flowers
    }
    
    mutating func next() -> Flower? {
        guard currentIndex < flowers.count else {
            return nil
        }
        
        let nextFlower = flowers[currentIndex]
        currentIndex += 1
        return nextFlower
    }
}

// MARK: - Conform Flower to Sequence
extension Flower: Sequence {
    func makeIterator() -> FlowerIterator {
        return FlowerIterator(flowers: [self])
    }
}
