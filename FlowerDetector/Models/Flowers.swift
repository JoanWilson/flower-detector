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
struct Flower: Codable {
    let name, namePortuguese, scientificName, description: String
}
