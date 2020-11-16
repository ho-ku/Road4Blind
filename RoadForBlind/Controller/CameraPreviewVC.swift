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
    private var timerService: TimerService!
    // MARK: - Lifecycle
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setupServices()
        timerService.startTimer()
        previewService.startStreaming()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        timerService.stopTimer()
        previewService.stopStreaming()
    }
    
    private func setupServices() {
        previewService = DependencyInjection.shared.previewService(with: self.mainView.cameraPreviewView.bounds)
        timerService = DependencyInjection.shared.timerService()
        timerService.delegate = self
        previewService.delegate = self
    }
    
}
// MARK: - PreviewServiceDelegate
extension CameraPreviewVC: PreviewServiceDelegate {
    
    func didFinishSetupLivePreview(with previewLayer: AVCaptureVideoPreviewLayer) {
        mainView.cameraPreviewView.layer.addSublayer(previewLayer)
    }
    
    func didProceedWithImage(_ data: Data) {
        
    }
    
}
// MARK: - TimerServiceDelegate
extension CameraPreviewVC: TimerServiceDelegate {
    
    func didPassTimeInterval() {
        print("spent")
    }
    
}
