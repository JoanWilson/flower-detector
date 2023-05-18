//
//  DetailView.swift
//  FlowerDetector
//
//  Created by Joan Wilson Oliveira on 18/05/23.
//

import SwiftUI

struct DetailView: View {
    var body: some View {
        ScrollView {
        
                Image("orchid")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: UIScreen.main.bounds.height * 0.4)
                    .clipped()
                
            VStack {
                Text("Orquídea")
                    .font(.largeTitle)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(.green)
                    
                Text("Orquídea")
                    .font(.largeTitle)
                Text("Orquídea")
                    .font(.largeTitle)
                Text("Orquídea")
                    .font(.largeTitle)
            }.frame(maxWidth: .infinity)
            
                
            
            
                
        }.edgesIgnoringSafeArea(.top)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}

struct ShadowModifier: ViewModifier {
  func body(content: Content) -> some View {
    content
       .shadow(color: Color("darkShadow"), radius: 8, x: 8, y: 8)
  }
}
