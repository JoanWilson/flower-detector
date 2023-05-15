////
////  IdentifierView2.swift
////  FlowerDetector
////
////  Created by Joan Wilson Oliveira on 11/05/23.
////
//
//import SwiftUI
//import CoreML
//import Vision
//
//struct CaptureImageView: View {
//    @Binding var showImagePicker: Bool
//    @Binding var image: UIImage?
//    @ObservedObject var viewModel: CameraViewModel
//    @Binding var analysisResults: [AnalysisResult]
//    @Binding var showAnalysis: Bool
//    
//    var body: some View {
//        ZStack {
//            Rectangle()
//                .fill(Color.secondary)
//            
//            if let image = image {
//                Image(uiImage: image)
//                    .resizable()
//                    .scaledToFit()
//            } else {
//                Text("Tap to take a picture")
//                    .foregroundColor(.white)
//                    .font(.headline)
//            }
//        }
//        .onTapGesture {
//            showImagePicker = true
//        }
//        .sheet(isPresented: $showImagePicker) {
//            ImagePicker(image: $image)
//                .onDisappear {
//                    if let image = self.image {
//                        if let result = self.viewModel.analyzeImage(image) {
//                            DispatchQueue.main.async {
//                                self.analysisResults.append(AnalysisResult(image: image, result: result))
//                                self.showAnalysis = true
//                            }
//                        }
//                    }
//                }
//        }
//        .sheet(isPresented: $showAnalysis) {
//            AnalysisView(analysisResults: $analysisResults, showAnalysis: $showAnalysis)
//        }
//    }
//}
//
//class CameraViewModel: NSObject, ObservableObject {
//    @Published var analysisResults: [AnalysisResult] = []
//    
//    func analyzeImage(_ image: UIImage) {
//        guard let model = try? VNCoreMLModel(for: FlowerDetector().model) else {
//            fatalError("Failed to load CoreML model")
//        }
//        
//        let request = VNCoreMLRequest(model: model) { [weak self] (request, error) in
//            guard let results = request.results as? [VNClassificationObservation], let topResult = results.first else {
//                return
//            }
//            
//            let result = AnalysisResult(image: image, result: "\(topResult.identifier) \(topResult.confidence)")
//            
//            DispatchQueue.main.async {
//                self?.analysisResults.append(result)
//            }
//        }
//        
//        guard let ciImage = CIImage(image: image) else {
//            fatalError("Failed to convert UIImage to CIImage")
//        }
//        
//        let imageHandler = VNImageRequestHandler(ciImage: ciImage, options: [:])
//        
//        do {
//            try imageHandler.perform([request])
//        } catch {
//            print("Failed to perform image analysis: \(error.localizedDescription)")
//        }
//    }
//}
//
//struct AnalysisResult: Identifiable {
//    let id = UUID()
//    let image: UIImage
//    let result: String
//}
//
//struct ImagePicker: UIViewControllerRepresentable {
//    @Binding var image: UIImage?
//    @Binding var isShown: Bool
//    
//    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
//        let imagePicker = UIImagePickerController()
//        imagePicker.sourceType = .camera
//        imagePicker.delegate = context.coordinator
//        return imagePicker
//    }
//    
//    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
//    }
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//    
//    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//        let parent: ImagePicker
//        
//        init(_ parent: ImagePicker) {
//            self.parent = parent
//        }
//        
//        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//            if let uiImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
//                parent.image = uiImage
//            }
//            parent.isShown = false
//        }
//        
//        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//            parent.isShown = false
//        }
//    }
//}
//
//struct AnalysisView: View {
//    @Binding var analysisResults: [AnalysisResult]
//    @Binding var showAnalysis: Bool
//    
//    var body: some View {
//        NavigationView {
//            if !analysisResults.isEmpty {
//                List(analysisResults) { result in
//                    Image(uiImage: result.image)
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 50, height: 50)
//                    Text(result.result)
//                }
//            } else {
//                Text("No analysis results available")
//            }
//            .navigationTitle("Analysis Results")
//            .navigationBarItems(trailing:
//                Button("Done") {
//                    showAnalysis = false
//                }
//            )
//        }
//    }
//}
//
