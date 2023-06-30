//
//  AboutView.swift
//  FlowerDetector
//
//  Created by Joan Wilson Oliveira on 18/05/23.
//

import SwiftUI

struct AboutView: View {
    
//    init() {
//        let design = UIFontDescriptor.SystemDesign.serif
//        let descriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .largeTitle)
//            .withDesign(design)!
//        let font = UIFont.init(descriptor: descriptor, size: 48)
//        UINavigationBar.appearance().largeTitleTextAttributes = [.font : font]
//        
//    }
//    
    var body: some View {
        NavigationStack {
            List {
                NavigationLink("Créditos") {
                    
                        List {
                            Section("Imagens") {
                                Link(
                                    destination: URL(string: "https://unsplash.com/")!) {
                                        Text("As imagens foram proporcionadas pelo Unsplash de maneira gratuita.")
                                    }
                                
                            }
                            
                            Section {
                                Link(
                                    destination: URL(string: "https://www.kaggle.com/datasets/l3llff/flowers")!) {
                                        Text("Flowers - L3IFF")
                                    }
                                Link(
                                    destination: URL(string: "https://www.kaggle.com/datasets/alxmamaev/flowers-recognition")!) {
                                        Text("Flowers Recognition - Alexander Mamaev")
                                    }
                            } header: {
                                Text("Dataset obtido no Kaggle")
                            }
                            
                            Section("Modelo de IA") {
                                Text("O modelo foi treinado através da ferramenta CreateML da Apple.")
                            }
                        }
                        .navigationTitle("Créditos")
                        .listStyle(.plain)
                    
                    
                }
                
                NavigationLink("Como usar?") {
                    Text("Tutorial")
                }.disabled(true)
                
                NavigationLink("Quem desenvolveu?") {
                    Text("Tutorial")
                }.disabled(true)
                
                Button("Me pague um café") {
                    print("Pagou")
                }.disabled(true)
                
            }
            .navigationTitle("Sobre")
            .listStyle(.plain)
        }
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
