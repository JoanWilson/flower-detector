//
//  CameraView.swift
//  FlowerDetector
//
//  Created by Joan Wilson Oliveira on 11/05/23.
//

import SwiftUI

struct CameraView: View {
    @State var showCamera: Bool = false
    @State var showDetail: Bool = false
    @State var image: UIImage? = nil
    let predictionsToShow = 4
    private let classifier = ImagePredictor()
    private let localManager = LocalManager()
    @State var path: NavigationPath = NavigationPath()
    @State var predictions: [Prediction] = []
    @State var allFlowers: [Flower] = []
    @State var showLoadingModal: Bool = false
    
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    Text("Imagem a ser classificada")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 25)
                    
                        .fontDesign(.serif)
                    
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
                        
                        Button {
                            showCamera.toggle()
                            showLoadingModal.toggle()
                        } label: {
                            HStack {
                                VStack {
                                    if showLoadingModal == true {
                                        ProgressView("Carregando Câmera")
                                            .foregroundColor(.gray)
                                    } else {
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
                        
                        
                    }
                    VStack {
                        if predictions.isEmpty {
                            
                        } else {
                            Text("Resultados da análise")
                                .font(.headline)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                                .fontDesign(.serif)
                            
                            Text("Clique em qualquer uma das predições abaixo para saber mais sobre a possível espécie identificada.")
                                .font(.subheadline)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .fontDesign(.serif)
                            
                            VStack {
                                ForEach(predictions, id: \.self) { prediction in
                                    VStack(alignment: .leading) {
                                        NavigationLink {
                                            DetailView(prediction: prediction.classification)
                                            //                                            showDetail.toggle()
                                        } label: {
                                            VStack(alignment: .leading) {
                                                Text(prediction.classification)
                                                HStack {
                                                    
                                                    Rectangle()
                                                        .size(width: (UIScreen.main.bounds.width*0.7)*getDouble(prediction.confidencePercentage), height: 25)
                                                        .cornerRadius(5)
                                                        .foregroundColor(Color.green)
                                                    
                                                    Text("\(prediction.confidencePercentage)%")
                                                        .font(.headline)
                                                    
                                                }
                                            }.background(Color(UIColor.systemGray6))
                                            
                                            
                                            
                                        }
                                        .padding(.horizontal)
                                        .buttonStyle(.plain)
                                        
                                        
                                    }
                                    
                                    
                                    Divider()
                                }
                            }
                            .frame(
                                width: UIScreen.main.bounds.width * 0.9
                            )
                            .padding(.top)
                            .background(Color(UIColor.systemGray6))
                            .cornerRadius(10)
                        }
                    }
                    .padding(25)
                    
                    Spacer()
                }
                
            }
            .navigationTitle("Identificador")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showCamera.toggle()
                        print(showCamera)
                    } label: {
                        Image(systemName: "camera.circle.fill")
                            .resizable()
                            .frame(width: 35, height: 35)
                            .tint(.green)
                    }.fullScreenCover(isPresented: $showCamera) {
                        CameraRepresentable(isPresented: $showCamera, delegate: self)
                            .ignoresSafeArea(.all)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        
                    } label: {
                        Image(systemName: "photo.circle.fill")
                            .resizable()
                            .frame(width: 35, height: 35)
                            .tint(.green)
                    }.disabled(true)
                }
            }
            .onAppear {
                let flowers = localManager.loadJson(fileName: "flowerData")
                guard let flowersWrapped = flowers else {
                    return
                }
                self.allFlowers = flowersWrapped.flowers
            }
            
            
        }
    }
}



extension CameraView: CameraRepresentableDelegate {
    
    func modalLoadingToggle() {
        self.showLoadingModal.toggle()
    }
    
    func getFlowerWithPredictionName(_ prediction: String) -> Flower {
        for flower in self.allFlowers {
            print(flower.name)
            if flower.namePortuguese == prediction.lowercased() {
                return flower
            }
        }
        return Flower(name: "Unknown", namePortuguese: "Unknown", scientificName: "Unknown", description: "Unknown")
    }
    
    func getFlowerNameInPortuguese(_ flowerString: String) -> String {
        
        for flower in self.allFlowers {
            if flower.name == flowerString.lowercased() {
                return flower.namePortuguese.capitalized
            }
        }
        
        return "Unknown"
    }
    
    func getDouble(_ string: String) -> Double {
        
        guard let percentage = Double(string) else {
            return 1
        }
        return  percentage / 100
        
    }
    
    func classifyImage(_ uiImage: UIImage) {
        self.predictions = []
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
        
        //        let predictionString = formattedPredictions.joined(separator: "\n")
        
        var count = 1
        for prediction in predictions {
            if count > 4 {
                break
            }
            let predicitionNamePortuguese = getFlowerNameInPortuguese(prediction.classification)
            let newPrediction = Prediction(classification: predicitionNamePortuguese, confidencePercentage: prediction.confidencePercentage)
            
            self.predictions.append(newPrediction)
            count += 1
        }
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
