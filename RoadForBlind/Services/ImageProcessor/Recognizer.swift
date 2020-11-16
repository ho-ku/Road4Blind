//
//  Recognizer.swift
//  RoadForBlind
//
//  Created by Денис Андриевский on 16.11.2020.
//

import Foundation
import CoreImage

protocol Recognizer: class {
    func proceed(_ image: CIImage, completionHandler: @escaping ([String]) -> Void)
}
