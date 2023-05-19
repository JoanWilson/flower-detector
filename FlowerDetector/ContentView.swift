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
        let design = UIFontDescriptor.SystemDesign.serif
        let descriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .largeTitle)
            .withDesign(design)!
        let font = UIFont.init(descriptor: descriptor, size: 48)
        UINavigationBar.appearance().largeTitleTextAttributes = [.font : font]
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
//        navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
//
//        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 24, weight: .regular, scale: .large)
//
//        let backImage = UIImage(systemName: "chevron.left.circle.fill")?
//            .withConfiguration(symbolConfiguration)
//            .applyingSymbolConfiguration(.init(paletteColors: [.black, .white]))
//        let backButton = UIBarButtonItem(image: backImage, style: .plain, target: nil, action: nil)
        navigationBar.topItem?.backButtonTitle = ""
//        navigationBar.topItem?.backBarButtonItem = backButton
        
        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 24, weight: .regular, scale: .large)

        let backImage = UIImage(systemName: "chevron.left.circle.fill")?
            .withConfiguration(symbolConfiguration)
            .applyingSymbolConfiguration(.init(paletteColors: [.black, .white]))

        let scrollEdgeNavBarAppearance = UINavigationBarAppearance()
        scrollEdgeNavBarAppearance.setBackIndicatorImage(backImage, transitionMaskImage: backImage)
        scrollEdgeNavBarAppearance.configureWithTransparentBackground()

        
        let design = UIFontDescriptor.SystemDesign.serif
        let descriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .largeTitle)
            .withDesign(design)!
        let font = UIFont.init(descriptor: descriptor, size: 48)
        
        scrollEdgeNavBarAppearance.largeTitleTextAttributes = [.font : font]
        
        navigationBar.scrollEdgeAppearance = scrollEdgeNavBarAppearance
        
        
        
        


    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
