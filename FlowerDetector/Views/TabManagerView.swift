//
//  TabManagerView.swift
//  FlowerDetector
//
//  Created by Joan Wilson Oliveira on 10/05/23.
//

import SwiftUI

struct TabManagerView: View {
    
    init() {
        let design = UIFontDescriptor.SystemDesign.serif
        let descriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .largeTitle)
            .withDesign(design)!
        let font = UIFont.init(descriptor: descriptor, size: 48)
        UINavigationBar.appearance().largeTitleTextAttributes = [.font : font]
    }
    
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
            AboutView()
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
