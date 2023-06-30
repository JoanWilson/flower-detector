//
//  Predictiin.swift
//  FlowerDetector
//
//  Created by Joan Wilson Oliveira on 23/05/23.
//

import Foundation

struct Prediction: Hashable {
    var classification: String
    let confidencePercentage: String

    
    func hash(into hasher: inout Hasher) {
        hasher.combine(classification)
        hasher.combine(confidencePercentage)
    }
    
    static func ==(lhs: Prediction, rhs: Prediction) -> Bool {
        return lhs.classification == rhs.classification && lhs.confidencePercentage == rhs.confidencePercentage
    }
}
