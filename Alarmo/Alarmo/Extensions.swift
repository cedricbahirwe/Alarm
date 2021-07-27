//
//  Extensions.swift
//  Alarmo
//
//  Created by Cédric Bahirwe on 27/07/2021.
//

import SwiftUI

extension Color {
    static let lightGreen = Color("lightGreen")
}


public func getReadableTimeFormat(amount: Int, type: String) -> String {
    let (hrs, minsec) = amount.quotientAndRemainder(dividingBy: 3600)
    let (min, sec) = minsec.quotientAndRemainder(dividingBy: 60)
    return type == "s" ? "\(hrs)h:\(min)m" : "\(String(format: "%02d", hrs)):\(String(format: "%02d", min)):\(String(format: "%02d", sec))"
}
