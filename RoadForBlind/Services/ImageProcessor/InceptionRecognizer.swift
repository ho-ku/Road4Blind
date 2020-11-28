//
//  ImageRecognizer.swift
//  RoadForBlind
//
//  Created by Денис Андриевский on 16.11.2020.
//

import Foundation
import Vision
import CoreML
import CoreImage

final class InceptionRecognizer: Recognizer {
    
    func proceed(_ image: CIImage, completionHandler: @escaping ([String]) -> Void) {
        guard let model = try? VNCoreMLModel(for: Inceptionv3(configuration: MLModelConfiguration()).model) else {
            completionHandler([])
            return
        }
        let request = VNCoreMLRequest(model: model) { (request, error) in
            guard let results = request.results as? [VNClassificationObservation] else {
                completionHandler([])
                return
            }
            completionHandler(results.map { $0.identifier })
        }
        let handler = VNImageRequestHandler(ciImage: image)
        do {
            try handler.perform([request])
        } catch {
            print("Erorr performing request")
        }
    }
    
}
