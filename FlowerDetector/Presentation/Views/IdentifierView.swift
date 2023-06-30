////
////  IdentifierView.swift
////  FlowerDetector
////
////  Created by Joan Wilson Oliveira on 10/05/23.
//
//
//
//import SwiftUI
//import AVFoundation
//import CoreML
//import Vision
//
//struct CameraView: UIViewRepresentable {
//    
//    @Binding var image: UIImage?
//    var onCapture: () -> Void
//    
//    func makeCoordinator() -> Coordinator {
//        return Coordinator(parent: self)
//    }
//    
//    func makeUIView(context: Context) -> UIView {
//        let view = UIView(frame: UIScreen.main.bounds)
//        let captureSession = AVCaptureSession()
//        
//        guard let frontCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else {
//            fatalError("Unable to access front camera.")
//        }
//        
//        do {
//            let input = try AVCaptureDeviceInput(device: frontCamera)
//            captureSession.addInput(input)
//        } catch {
//            fatalError("Unable to access front camera.")
//        }
//        
//        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
//        previewLayer.frame = view.layer.bounds
//        previewLayer.videoGravity = .resizeAspectFill
//        view.layer.addSublayer(previewLayer)
//        
//        let videoOutput = AVCaptureVideoDataOutput()
//        videoOutput.setSampleBufferDelegate(context.coordinator, queue: DispatchQueue(label: "camera_frame_processing_queue"))
//        captureSession.addOutput(videoOutput)
//        
//        DispatchQueue.global().async {
//            captureSession.startRunning()
//        }
//        
//        
//        return view
//    }
//    
//    func updateUIView(_ uiView: UIView, context: Context) {}
//    
//    class Coordinator: NSObject, AVCaptureVideoDataOutputSampleBufferDelegate {
//        
//        var parent: CameraView
//        
//        init(parent: CameraView) {
//            self.parent = parent
//        }
//        
//        func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
//            guard let pixelBuffer: CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
//            let ciImage = CIImage(cvPixelBuffer: pixelBuffer)
//            let context = CIContext()
//            guard let cgImage = context.createCGImage(ciImage, from: ciImage.extent) else { return }
//            let imageFirst = UIImage(cgImage: cgImage)
//            let image = UIImage(cgImage: cgImage, scale: imageFirst.scale, orientation: .right)
//            DispatchQueue.main.async {
//                self.parent.image = image
//                self.parent.onCapture()
//            }
//        }
//    }
//}
//
//
//struct CameraViewModel {
//    
//    func analyzeImage(_ image: UIImage) -> String? {
//        guard let model = try? VNCoreMLModel(for: FlowerDetector().model) else {
//            fatalError("Failed to load CoreML model")
//        }
//        
//        let request = VNCoreMLRequest(model: model) { (request, error) in
//            guard let results = request.results as? [VNClassificationObservation], let topResult = results.first else {
//                return
//            }
//            print("\(topResult.identifier) \(topResult.confidence)")
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
//            guard let results = request.results as? [VNClassificationObservation], let topResult = results.first else {
//                return nil
//            }
//            return "\(topResult.identifier) \(topResult.confidence)"
//        } catch {
//            print("Failed to perform image analysis: \(error.localizedDescription)")
//            return nil
//        }
//    }
//}
//
//
//struct IdentifierView: View {
//    
//    @State private var showCamera = false
//    @State private var image: UIImage?
//    @State private var analysisResult: String?
//    @State private var analysisResults: [AnalysisResult] = []
//    
//    var body: some View {
//        NavigationView {
//            VStack {
//                if let image = image {
//                    Image(uiImage: image)
//                        .resizable()
//                        .scaledToFill()
//                        .padding()
//                } else {
//                    Text("Take a picture")
//                        .font(.title)
//                        .foregroundColor(.gray)
//                        .padding()
//                }
//                
//                Button(action: {
//                    self.showCamera = true
//                }, label: {
//                    Text("Take Picture")
//                        .font(.title)
//                        .foregroundColor(.white)
//                        .padding()
//                        .background(Color.blue)
//                        .cornerRadius(10)
//                })
//                
//                List(analysisResults) { result in
//                    NavigationLink(destination: AnalysisResultView(result: result)) {
//                        Text(result.result)
//                    }
//                }
//            }
//            .sheet(isPresented: $showCamera, onDismiss: {
//                if let image = self.image {
//                    self.analysisResult = CameraViewModel().analyzeImage(image)
//                    if let result = self.analysisResult {
//                        self.analysisResults.append(AnalysisResult(id: UUID(), result: result))
//                    }
//                }
//            }, content: {
//                CameraView(image: self.$image, onCapture: {
////                    self.showCamera = false
//                })
//            })
//            .navigationBarTitle("Identificador")
//        }
//    }
//}
//
//struct AnalysisResultView: View {
//    var result: AnalysisResult
//    
//    var body: some View {
//        Text(result.result)
//    }
//}
//
//struct AnalysisResult: Identifiable {
//    var id: UUID
//    var result: String
//}
//
//struct Previews_IdentifierView_Previews: PreviewProvider {
//    static var previews: some View {
//        IdentifierView()
//    }
//}
