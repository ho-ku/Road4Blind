//
//  TimerService.swift
//  RoadForBlind
//
//  Created by Денис Андриевский on 16.11.2020.
//

import Foundation

enum TimerState {
    case usual
    case road
}

protocol TimerServiceDelegate: class {
    func didPassTimeInterval()
}

protocol TimerService: class {
    func startTimer()
    func stopTimer()
    var timerState: TimerState { get set }
    var delegate: TimerServiceDelegate? { get set }
}
