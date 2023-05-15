//
//  CameraView.swift
//  FlowerDetector
//
//  Created by Joan Wilson Oliveira on 11/05/23.
//

import SwiftUI

struct CameraView: View {
    @State var showCamera: Bool = false
    @State var image: UIImage = UIImage(named: "dente")!
    let predictionsToShow = 4
    private let classifier = ImagePredictor()
    
    
    var body: some View {
        VStack {
            Image(uiImage: image)
                .resizable()
                .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.3)
                .scaledToFill()
                .cornerRadius(10)
                .clipped()
            
            Spacer()
            
            Button {
                showCamera.toggle()
            } label: {
                Text("Clique aqui")
                    .padding()
                    .background(.secondary)
                    .cornerRadius(8)
            }
            .fullScreenCover(isPresented: $showCamera) {
                CameraRepresentable(isPresented: $showCamera, delegate: self)
                    .ignoresSafeArea(.all)
            }
        }
    }
}

extension CameraView: CameraRepresentableDelegate {
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
