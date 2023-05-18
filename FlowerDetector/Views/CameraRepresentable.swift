//
//  CameraView.swift
//  FlowerDetector
//
//  Created by Joan Wilson Oliveira on 11/05/23.
//

import SwiftUI

protocol CameraRepresentableDelegate {
    func setImage(uiImage: UIImage)
    func classifyImage(_ uiImage: UIImage)
}

struct CameraRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIImagePickerController
    
    @Binding var isPresented: Bool
    
    private var delegate: CameraRepresentableDelegate
    
    init(isPresented: Binding<Bool>, delegate: CameraRepresentableDelegate) {
        self._isPresented = isPresented
        self.delegate = delegate
    }
    
    func makeUIViewController(context: Context) -> UIViewControllerType {
        let viewController = UIViewControllerType()
        viewController.delegate = context.coordinator
        viewController.sourceType = .camera
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
    
    func makeCoordinator() -> CameraRepresentable.Coordinator {
        return Coordinator(parent: self)
    }
}

extension CameraRepresentable {
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: CameraRepresentable
        
        init(parent: CameraRepresentable) {
            self.parent = parent
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            self.parent.isPresented = false
            print("Cancel pressed")
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                
                print("Carregando...")
                DispatchQueue.global().async {
                    self.parent.delegate.classifyImage(image)
                    DispatchQueue.main.async {
                        self.parent.delegate.setImage(uiImage: image)
                        self.parent.isPresented = false
                        
                        print("Carregou")
                    }
                }
                
            }
        }
    }
}
