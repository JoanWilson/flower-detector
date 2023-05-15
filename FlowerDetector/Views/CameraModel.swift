//
//  CameraModel.swift
//  FlowerDetector
//
//  Created by Joan Wilson Oliveira on 10/05/23.
//

//import SwiftUI
//import AVFoundation
//
//struct CameraView: View {
//    var body: some View {
//        NavigationStack {
//            ZStack {
//                Color.black
//                    .ignoresSafeArea(.all, edges: .top)
//            }
//            
//            VStack {
//                Spacer()
//                
//                HStack {
//                    Button {
//                        
//                    } label: {
//                        <#code#>
//                    }
//                }
//            }
//            
//        }.toolbarBackground(
//            Color(.systemBackground),
//            for: .navigationBar)
//        
//    }
//}
//
//class CameraModel: ObservableObject {
//    @Published var isTaken = false
//    @Published var session = AVCaptureSession()
//    
//    func checkAuthorization() {
//        switch AVCaptureDevice.authorizationStatus(for: .video) {
//        case .authorized:
//            setUp()
//            return
//        case .notDetermined:
//            AVCaptureDevice.requestAccess(for: .video) { status in
//                if status {
//                    self.setUp()
//                }
//            }
//        case .denied:
//            return
//        default:
//            return
//        }
//    }
//    
//    func setUp() {
//        
//    }
//}
//
//
//struct CameraView_Previews: PreviewProvider {
//    static var previews: some View {
//        CameraView()
//    }
//}


