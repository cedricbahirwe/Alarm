//
//  TimerMager.swift
//  Alarmo
//
//  Created by Cédric Bahirwe on 27/07/2021.
//

import Foundation

class TimerManager: ObservableObject {
    
    enum TimerState { case initial, running, pause }
    
    @Published var hr: Int = 0
    @Published var min: Int = 0
    @Published var sec: Int = 0
    
    @Published var timerState = TimerState.initial
    
    var canStartTimer: Bool { hr + min + sec > 0 }
    public var duration:  Int {
        ((hr * 3600) + (min * 60) + sec)
    }
    
}
