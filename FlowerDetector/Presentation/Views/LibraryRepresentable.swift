//
//  LibraryRepresentable.swift
//  FlowerDetector
//
//  Created by Joan Wilson Oliveira on 02/07/23.
//

import PhotosUI
import SwiftUI

struct LibraryRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = PHPickerViewController
    
    @Binding var isPresented: Bool
    
    private var delegateToSelectView: CameraRepresentableDelegate
    
    init(isPresented: Binding<Bool>, delegateToSelectView: CameraRepresentableDelegate) {
        self._isPresented = isPresented
        self.delegateToSelectView = delegateToSelectView
    }
    
    func makeUIViewController(context: Context) -> UIViewControllerType {
        var config = PHPickerConfiguration()
        config.filter = .images
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    internal class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: LibraryRepresentable
        
        init(parent: LibraryRepresentable) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            guard let provider = results.first?.itemProvider else { return }
            
            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { (imageProvided, error) in
                    if let image = imageProvided as? UIImage {
                        DispatchQueue.global().async {
                            self.parent.delegateToSelectView.classifyImage(image)
                            
                            DispatchQueue.main.async {
                                self.parent.delegateToSelectView.setImage(uiImage: image)
                                self.parent.isPresented = false
                                print("Carregou")
                            }
                        }
                    } else {
                        print("Could not load the Image")
                    }
                    
//                    let alertController = UIAlertController(title: "", message: nil, preferredStyle: .alert)
//
//                    // Create an activity indicator
//                    let indicator = UIActivityIndicatorView(style: .medium)
//                    indicator.translatesAutoresizingMaskIntoConstraints = false
//                    indicator.color = UIColor.systemGreen
//                    indicator.startAnimating()
//
//                    // Add the activity indicator to the alert controller's view
//                    alertController.view.addSubview(indicator)
//
//                    // Add constraints to center the activity indicator
//                    indicator.centerXAnchor.constraint(equalTo: alertController.view.centerXAnchor).isActive = true
//                    indicator.centerYAnchor.constraint(equalTo: alertController.view.centerYAnchor).isActive = true
//
//                    alertController.preferredContentSize = CGSize(width: alertController.preferredContentSize.width, height: 150)
//                    // Present the alert controller
//                    picker.present(alertController, animated: true, completion: nil)
                    
                    
                }
                
            }
        }
    }
}
