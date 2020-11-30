//
//  ResultProcessor.swift
//  RoadForBlind
//
//  Created by Денис Андриевский on 30.11.2020.
//

import Foundation

protocol ResultProcessor {
    func proceed(with state: SignState, completionHandler: @escaping (SignState) -> Void)
}
