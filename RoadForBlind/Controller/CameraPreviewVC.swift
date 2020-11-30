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
    private var recognizer: Recognizer!
    private var resultProcessor: ResultProcessor!
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
        recognizer = DependencyInjection.shared.recognizer()
        resultProcessor = DependencyInjection.shared.resultProcessor()
    }
    
}
// MARK: - PreviewServiceDelegate
extension CameraPreviewVC: PreviewServiceDelegate {
    
    func didFinishSetupLivePreview(with previewLayer: AVCaptureVideoPreviewLayer) {
        mainView.cameraPreviewView.layer.addSublayer(previewLayer)
    }
    
    func didProceedWithImage(_ data: Data) {
        guard let ciImage = CIImage(data: data) else { return }
        recognizer.proceed(ciImage) { [unowned self] (results) in
            let mainResults = results.prefix(7).reduce(" ", +)
            var resultState: SignState = .none
            var attentionString: String?
            if mainResults.contains("traffic light") && !mainResults.contains(" car,") {
                resultState = .attention
                attentionString = "traffic light"
            } else if mainResults.contains(" car,") || mainResults.contains(" bike,") {
                resultState = .attention
                attentionString = "car"
            } else {
                resultState = .none
            }
            resultProcessor.proceed(with: resultState) { [unowned self] (newState) in
                self.mainView.updateState(newState)
                self.timerService.timerState = newState == .attention ? .road : .usual
                if let str = attentionString {
                    DispatchQueue.main.async { [unowned self] in
                        AlertService.presentSimpleOKAlert(self, title: "Detect", message: str)
                    }
                }
            }
        }
    }
    
}
// MARK: - TimerServiceDelegate
extension CameraPreviewVC: TimerServiceDelegate {
    
    func didPassTimeInterval() {
        previewService.capturePhoto()
    }
    
}
