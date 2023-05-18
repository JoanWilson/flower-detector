//
//  CameraView.swift
//  FlowerDetector
//
//  Created by Joan Wilson Oliveira on 11/05/23.
//

import SwiftUI

struct CameraView: View {
    @State var showCamera: Bool = false
    @State var image: UIImage? = nil
    let predictionsToShow = 4
    private let classifier = ImagePredictor()
    private let localManager = LocalManager()
    @State var path: NavigationPath = NavigationPath()
    @State var predictions: [Prediction] = []
    
    var body: some View {
        NavigationStack {
                ScrollView {
                    if image != nil {
                        Image(uiImage: image!)
                            .resizable()
                            .scaledToFill()
                            .frame(
                                width: UIScreen.main.bounds.width * 0.9,
                                height: UIScreen.main.bounds.height * 0.3
                            )
                            .cornerRadius(10)
                            .clipped()
                    } else {
                        HStack {
                            VStack {
                                Image(systemName: "camera.circle.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 40)
                                    .foregroundColor(.gray)
                                Text("Clique no botão de cima para adicionar ou bater uma foto da flor")
                                    .frame(maxWidth: 200)
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.gray)

                            }
                        }
                        .frame(
                            width: UIScreen.main.bounds.width * 0.9,
                            height: UIScreen.main.bounds.height * 0.3
                        )
                        .background(.regularMaterial)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.gray, lineWidth: 2)
                        )
                        .fullScreenCover(isPresented: $showCamera) {
                            CameraRepresentable(isPresented: $showCamera, delegate: self)
                                .ignoresSafeArea(.all)
                        }
                        .cornerRadius(10)
                        
                    }
                    VStack {
                        if predictions.isEmpty {
                             
                        } else {
                            Text("Resultados da análise")
                                .font(.headline)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            
                            VStack {
                                ForEach(predictions, id: \.self) { prediction in
                                    HStack {
                                        Text(prediction.classification)
                                        HStack {

                                            Rectangle()
                                                .size(width: (UIScreen.main.bounds.width*0.7)*getDouble(prediction.confidencePercentage), height: 20)
                                                .cornerRadius(10)
                                                .foregroundColor(Color.green)
                                            
                                            Text("\(prediction.confidencePercentage)%")
                                                .font(.headline)

                                        }
        
        
                                    }.padding(.horizontal)
                                    Divider()
                                }
                            }
                            .frame(
                                width: UIScreen.main.bounds.width * 0.9
                            )
                            .padding(.top)
                            .background(Color(UIColor.systemGray5))
                            .cornerRadius(10)
                        }
                        
                        
    
                    }
                    .padding(25)
            
                    Spacer()
                }
                .navigationTitle("Identificador")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            showCamera.toggle()
                        } label: {
                            Image(systemName: "camera.circle.fill")
                                .resizable()
                                .frame(width: 35, height: 35)
                                .tint(.green)
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            
                        } label: {
                            Image(systemName: "photo.circle.fill")
                                .resizable()
                                .frame(width: 35, height: 35)
                                .tint(.green)
                        }
                    }
                }
                
            
        }
    }
}



extension CameraView: CameraRepresentableDelegate {
    
    func getDouble(_ string: String) -> Double {
        
            guard let percentage = Double(string) else {
                return 1
            }
            return  percentage / 100
      
    }
    
    func classifyImage(_ uiImage: UIImage) {
        do {
            try self.classifier.makePredictions(for: uiImage, completionHandler: imagePredictionHandler)
        } catch {
            print("Vision was unable to make a prediction...\n\n\(error.localizedDescription)")
        }
    }
    
    func setImage(uiImage: UIImage) {
        image = uiImage
    }
    
    private func imagePredictionHandler(_ predictions: [Prediction]?) {
        guard let predictions = predictions else {
            print("No predictions. (Check console log.)")
            return
        }
        
        let formattedPredictions = formatPredictions(predictions)
        
        let predictionString = formattedPredictions.joined(separator: "\n")
        dump(predictionString)
    }
    
    private func formatPredictions(_ predictions: [Prediction]) -> [String] {
        // Vision sorts the classifications in descending confidence order.
        let topPredictions: [String] = predictions.prefix(predictionsToShow).map { prediction in
            var name = prediction.classification
            
            // For classifications with more /Users/joanwilsonoliveira/Desktop/FlowerDetector/FlowerDetector/Views/CameraView.swiftthan one name, keep the one before the first comma.
            if let firstComma = name.firstIndex(of: ",") {
                name = String(name.prefix(upTo: firstComma))
            }
            
            return "\(name) - \(prediction.confidencePercentage)%"
        }
        
        return topPredictions
    }
    
}

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView()
    }
}
