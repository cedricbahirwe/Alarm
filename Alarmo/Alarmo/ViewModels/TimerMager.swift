//
//  TimerMager.swift
//  Alarmo
//
//  Created by Cédric Bahirwe on 27/07/2021.
//

import Foundation

class TimerManager: ObservableObject {
    
    enum TimerState { case initial, running, paused }
    
    @Published var hr: Int = 0
    @Published var min: Int = 0
    @Published var sec: Int = 0
    @Published var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @Published var timerState = TimerState.initial
    
    var canStartTimer: Bool { hr + min + sec > 0 }
    public var duration:  Int {
        ((hr * 3600) + (min * 60) + sec)
    }
    
    public func manageTimer() {
        if timerState == .running  {
            pauseTimer()
        } else {
            startTimer()
        }
    }
    
    
    private func startTimer() {
        timerState = .running
        timer = Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()

    }
    
    private func pauseTimer() {
        timerState = .paused
        timer.upstream.connect().cancel()
    }
    
    
    public func resetTimer() {
        timerState = .initial
        timer.upstream.connect().cancel()
        (hr, min, sec ) = (0,0,0)
    }
    
}
