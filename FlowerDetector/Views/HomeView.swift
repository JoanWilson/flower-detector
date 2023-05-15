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
    let data = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5", "Item 6"]
    
    var body: some View {
        NavigationStack(path: $homeViewPaths) {
            VStack {
                
                let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
                ScrollView {
                    LazyVGrid(columns: columns) {
                        ForEach(data.filter { searchText.isEmpty ? true : $0.contains(searchText) }, id: \.self) { item in
                            Text(item)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.gray.opacity(0.2))
                        }
                    }
                }
            }
            .searchable(text: $searchText)
            .navigationTitle("Flores")
            
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
