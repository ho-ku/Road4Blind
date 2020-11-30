//
//  R4BResultProcessor.swift
//  RoadForBlind
//
//  Created by Денис Андриевский on 30.11.2020.
//

import Foundation

final class R4BResultProcessor: ResultProcessor {
    
    private var lastState: SignState = .none
    
    func proceed(with state: SignState, completionHandler: @escaping (SignState) -> Void) {
        completionHandler((lastState == .none && state == .none) ? .none : .attention)
        lastState = state
    }
    
}
