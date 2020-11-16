//
//  CameraPreviewVC.swift
//  RoadForBlind
//
//  Created by Денис Андриевский on 16.11.2020.
//

import UIKit
import AVFoundation

final class CameraPreviewVC: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var mainView: CameraPreviewView!
    // MARK: - Properties
    private var previewService: PreviewService!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        previewService = DependencyInjection.shared.previewService(with: self.mainView.cameraPreviewView.bounds)
        previewService.delegate = self
        previewService.startStreaming()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        previewService.stopStreaming()
    }
    
}
extension CameraPreviewVC: PreviewServiceDelegate {
    
    func didFinishSetupLivePreview(with previewLayer: AVCaptureVideoPreviewLayer) {
        mainView.cameraPreviewView.layer.addSublayer(previewLayer)
    }
    
    func didProceedWithImage(_ data: Data) {
        
    }
    
}
