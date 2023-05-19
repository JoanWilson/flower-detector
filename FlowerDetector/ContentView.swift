//
//  ContentView.swift
//  FlowerDetector
//
//  Created by Joan Wilson Oliveira on 10/05/23.
//

import SwiftUI

struct ContentView: View {
    init() {
        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 24, weight: .regular, scale: .large)
        
        let backImage = UIImage(systemName: "chevron.left.circle.fill")?
            .withConfiguration(symbolConfiguration)
            .applyingSymbolConfiguration(.init(paletteColors: [.black, .white]))
        
        let scrollEdgeNavBarAppearance = UINavigationBarAppearance()
        scrollEdgeNavBarAppearance.setBackIndicatorImage(backImage, transitionMaskImage: backImage)
        scrollEdgeNavBarAppearance.configureWithTransparentBackground()
        
        UINavigationBar.appearance().scrollEdgeAppearance = scrollEdgeNavBarAppearance
    }
    
    var body: some View {
        TabManagerView()
            .tint(.green)
            .font(.system(.body, design: .serif))
    }
}

extension UINavigationController {
    // Remove back button text
    open override func viewWillLayoutSubviews() {
        navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
