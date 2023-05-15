//
//  TabManagerView.swift
//  FlowerDetector
//
//  Created by Joan Wilson Oliveira on 10/05/23.
//

import SwiftUI
import AVFoundation

struct TabManagerView: View {
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Flores", systemImage: "info")
                        .environment(\.symbolVariants, .none)
                }
            CameraView()
                .tabItem {
                    Image(systemName: "info")
                    Text("Identificar")
                }
            Text("About")
                .tabItem {
                    Label("Sobre", systemImage: "info")
                        .environment(\.symbolVariants, .none)
                }
        }
    }
}

struct TabManagerView_Previews: PreviewProvider {
    static var previews: some View {
        TabManagerView()
    }
}
