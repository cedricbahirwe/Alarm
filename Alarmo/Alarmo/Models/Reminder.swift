//
//  Reminder.swift
//  Alarmo
//
//  Created by Cédric Bahirwe on 27/07/2021.
//

import Foundation

struct Reminder: Identifiable, Hashable {
    let id: Int
    let date = Date()
    static let examples:[Reminder] = (1...10).map{ Reminder(id: $0) }
    
}
