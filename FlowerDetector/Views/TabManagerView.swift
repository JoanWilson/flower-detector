//
//  TabManagerView.swift
//  FlowerDetector
//
//  Created by Joan Wilson Oliveira on 10/05/23.
//

import SwiftUI

struct TabManagerView: View {
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Flores", systemImage: "camera.macro")
                        .environment(\.symbolVariants, .none)
                }
            CameraView()
                .tabItem {
                    Image(systemName: "camera.on.rectangle.fill")
                    Text("Identificar")
                }
            Text("About")
                .tabItem {
                    Label("Sobre", systemImage: "info.circle.fill")
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
