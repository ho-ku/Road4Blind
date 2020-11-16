//
//  R4BTimerService.swift
//  RoadForBlind
//
//  Created by Денис Андриевский on 16.11.2020.
//

import Foundation

final class R4BTimerService: TimerService {
    // MARK: - Properties
    var timerState: TimerState = .usual
    weak var delegate: TimerServiceDelegate?
    private var timer: Timer?
    private var timeInterval: Double = 0.0
    
    // MARK: - Init
    private func reloadTimer() {
        switch timerState {
        case .usual:
            timeInterval = C.usualTimerInterval
        case .road:
            timeInterval = C.roadTimerInterval
        }
        timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true, block: { [unowned self] _ in
            fireTimer()
        })
    }
    
    private func fireTimer() {
        delegate?.didPassTimeInterval()
    }
    
    // MARK: - Timer stuff
    func startTimer() {
        reloadTimer()
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
}
