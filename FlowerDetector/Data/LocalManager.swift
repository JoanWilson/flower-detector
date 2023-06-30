//
//  LocalManager.swift
//  FlowerDetector
//
//  Created by Joan Wilson Oliveira on 15/05/23.
//

import Foundation

class LocalManager {
    func loadJson(fileName: String) -> FlowersData? {
       let decoder = JSONDecoder()
       guard
            let url = Bundle.main.url(forResource: fileName, withExtension: "json"),
            let data = try? Data(contentsOf: url),
            let flowers = try? decoder.decode(FlowersData.self, from: data)
       else {
            return nil
       }
       return flowers
    }
}
