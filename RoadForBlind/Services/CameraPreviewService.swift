//
//  CameraPreviewService.swift
//  RoadForBlind
//
//  Created by Денис Андриевский on 16.11.2020.
//

import Foundation
import AVFoundation

final class CameraPreviewService: NSObject, PreviewService {
    
    // MARK: - Properties
    private var captureSession: AVCaptureSession!
    private var stillImageOutput: AVCapturePhotoOutput!
    private var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    private var bounds: CGRect!
    weak var delegate: PreviewServiceDelegate? {
        didSet {
            setupCaptureSession()
            setupImageOutput()
        }
    }
    // MARK: - Init
    init(bounds: CGRect) {
        super.init()
        self.bounds = bounds
    }
    // MARK: - Setup
    private func setupCaptureSession() {
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = .medium
    }
    
    private func setupImageOutput() {
        guard let backCamera = AVCaptureDevice.default(for: AVMediaType.video) else { return }
        do {
            let input = try AVCaptureDeviceInput(device: backCamera)
            stillImageOutput = AVCapturePhotoOutput()
            if captureSession.canAddInput(input) && captureSession.canAddOutput(stillImageOutput) {
                captureSession.addInput(input)
                captureSession.addOutput(stillImageOutput)
                setupLivePreview()
            }
        } catch let error  {
            print("Error:  \(error.localizedDescription)")
        }
    }
    
    private func setupLivePreview() {
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer.videoGravity = .resizeAspect
        videoPreviewLayer.connection?.videoOrientation = .portrait
        delegate?.didFinishSetupLivePreview(with: videoPreviewLayer)
    }
    
    // MARK: - Streaming stuff
    func startStreaming() {
        DispatchQueue.global(qos: .userInitiated).async { [unowned self] in
            self.captureSession.startRunning()
            DispatchQueue.main.async { [unowned self] in
                self.videoPreviewLayer.frame = self.bounds
            }
        }
    }
    
    func stopStreaming() {
        self.captureSession.stopRunning()
    }
    
    func capturePhoto() {
        let settings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
        stillImageOutput.capturePhoto(with: settings, delegate: self)
    }
    
}
// MARK: - AVCapturePhotoCaptureDelegate
extension CameraPreviewService: AVCapturePhotoCaptureDelegate {

    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let imageData = photo.fileDataRepresentation() else { return }
        delegate?.didProceedWithImage(imageData)
    }
    
}
