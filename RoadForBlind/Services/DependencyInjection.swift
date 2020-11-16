//
//  DependencyInjection.swift
//  RoadForBlind
//
//  Created by Денис Андриевский on 16.11.2020.
//

import CoreGraphics

final class DependencyInjection {
    
    static let shared = DependencyInjection()
    private init() { }
    
    func previewService(with bounds: CGRect) -> PreviewService {
        return CameraPreviewService(bounds: bounds)
    }
    
    func timerService() -> TimerService {
        return R4BTimerService()
    }
    
    func recognizer() -> Recognizer {
        return InceptionRecognizer()
    }
    
}
