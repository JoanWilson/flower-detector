//
//  DetailView.swift
//  FlowerDetector
//
//  Created by Joan Wilson Oliveira on 18/05/23.
//

import SwiftUI

struct DetailView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State var flower: Flower?
    var localManager = LocalManager()
    
    init(flower: Flower) {
        self._flower = State(initialValue: flower)
    }
    
    init(prediction: String) {
        let flowers = localManager.loadJson(fileName: "flowerData")
        guard let flowersWrapped = flowers else {
            self._flower = State(initialValue: Flower(name: "c", namePortuguese: "c", scientificName: "c", description: "c"))
            return
        }
        for flower in flowersWrapped.flowers {
            if flower.namePortuguese == prediction.lowercased() {
                self._flower = State(initialValue: flower)
                break
            }
        }
    }
    
    var body: some View {
        ScrollView {
            Image(flower?.name ?? "aster")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.4)
                
                .overlay {
                    Rectangle()
                            .fill(
                                LinearGradient(gradient: Gradient(colors: [Color.clear, Color.black]),
                                               startPoint: .top,
                                               endPoint: .bottom))
                            .frame(width: UIScreen.main.bounds.width,
                                   height: UIScreen.main.bounds.height,
                                   alignment: .center)
                }
                .clipped()
            
            
            VStack(spacing: 50) {
                VStack {
                    Text(flower?.namePortuguese.capitalized ?? "Unknown")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .fontDesign(.serif)
                        
                    Text(flower?.scientificName ?? "Unknown")
                        .font(.title2)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .fontDesign(.serif)
                }
                
                
                Text(flower?.description ?? "Unknown")
            }
            .frame(maxWidth: .infinity)
            .padding()
        }
        .edgesIgnoringSafeArea(.top)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(flower: Flower(name: "rose", namePortuguese: "Rose", scientificName: "Rose", description: "Lorem"))
    }
}

struct ShadowModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: Color("darkShadow"), radius: 8, x: 8, y: 8)
    }
}
