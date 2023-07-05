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
            picker.dismiss(animated: true)
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
                        self.showErrorAlert(message: "Falha ao carregar imagem, por favor tente novamente.", picker: picker)
                    }
                }
            } else if provider.hasItemConformingToTypeIdentifier(UTType.webP.identifier) {
                provider.loadDataRepresentation(forTypeIdentifier: UTType.webP.identifier) {data, err in
                    if let data = data,
                       let image = UIImage.init(data: data) {
                        DispatchQueue.global().async {
                            self.parent.delegateToSelectView.classifyImage(image)
                            
                            DispatchQueue.main.async {
                                self.parent.delegateToSelectView.setImage(uiImage: image)
                                self.parent.isPresented = false
                                print("Carregou")
                            }
                        }
                    } else {
                        self.showErrorAlert(message: "Falha ao carregar imagem, por favor tente novamente.", picker: picker)
                    }
                }
            } else {
                self.showErrorAlert(message: "Falha ao carregar imagem, por favor tente novamente.", picker: picker)
            }
        }
        
        
        
        func showErrorAlert(message: String, picker: PHPickerViewController) {
            let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            let okayAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okayAction)
            
            picker.present(alertController, animated: true, completion: nil)
            
        }
    }
}
