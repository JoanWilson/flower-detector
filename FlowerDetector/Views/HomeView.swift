//
//  HomeView.swift
//  FlowerDetector
//
//  Created by Joan Wilson Oliveira on 10/05/23.
//

import SwiftUI

struct HomeView: View {
    @State private var homeViewPaths = NavigationPath()
    @State private var searchText = ""
    var localManager = LocalManager()
    
    @State var data: [Flower] = []
    
    
    var body: some View {
        NavigationStack(path: $homeViewPaths) {
            VStack {
                
                let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
                ScrollView {
                    LazyVGrid(columns: columns) {
                        ForEach(data.filter { searchText.isEmpty ? true : $0.namePortuguese.lowercased().contains(searchText.lowercased()) }, id: \.namePortuguese) { item in
                            
                            NavigationLink {
                                
                            } label: {
                                VStack {
                                    Image(item.name)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: UIScreen.main.bounds.width*0.44, height: UIScreen.main.bounds.height*0.15)
                                        .clipped()
                                        .cornerRadius(6)
                                        .padding(.horizontal, 5)
                                    
                                    Text(item.namePortuguese.capitalized)
                                        .font(.subheadline)
                                    Text(item.scientificName.capitalized)
                                        .italic()
                                        .font(.caption)
                                }
                            }.buttonStyle(.plain)
                            
                            
                            
                        }
                    }.padding(.horizontal, 20)
                }
            }
            .searchable(text: $searchText)
            .navigationTitle("Flores")
            .onAppear {
                let flowers = localManager.loadJson(fileName: "flowerData")
                guard let flowersWrapped = flowers else {
                    return
                }
                
                self.data = flowersWrapped.flowers
            }
            
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


