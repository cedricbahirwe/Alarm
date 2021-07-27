//
//  StopWatchManager.swift
//  Alarmo
//
//  Created by Cédric Bahirwe on 27/07/2021.
//

import Foundation

class StopWatchManager: ObservableObject {
    enum TimerState { case running, paused, initial }
    @Published private(set) var timerState:TimerState = .initial
    @Published private(set) var generalCounter = 0
    @Published private(set) var mainTimerText = "00:00:00"
    @Published private(set) var lapTimerText = "00:00:00"
    
    private var timer = Timer()
    
    @Published var lapCounter = 0

    public func startStopTimer() {
        if timerState == .running  {
            pauseCounter()
        } else {
            startCounter()
        }
    }
    
    public func resetCounter() {
        timer.invalidate()
        timerState = .initial
    }
    
    private func startCounter() {
        timerState = .running
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { _ in self.updateCounting()
        })
    }
    
    private func updateCounting() {
        generalCounter += 1
        lapCounter += 1
        mainTimerText = getReadableTimeFormat(amount: generalCounter, type: "i")
        lapTimerText = getReadableTimeFormat(amount: lapCounter, type: "i")
    }
    
    private func pauseCounter() {
        timer.invalidate()
        timerState = .paused
    }

}
