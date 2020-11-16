//
//  PreviewServiceDelegate.swift
//  RoadForBlind
//
//  Created by Денис Андриевский on 16.11.2020.
//

import AVFoundation

protocol PreviewServiceDelegate: class {
    func didFinishSetupLivePreview(with previewLayer: AVCaptureVideoPreviewLayer)
    func didProceedWithImage(_ data: Data)
}

protocol PreviewService: class {
    var delegate: PreviewServiceDelegate? { get set }
    func startStreaming()
    func capturePhoto()
    func stopStreaming()
}
