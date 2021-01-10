//
//  DateUtils.swift
//  nwHacks2021
//
//  Created by Edward Luo on 2021-01-09.
//

import Foundation

func toDateString(from timestamp: Date, format: String = "y-MMM-d") -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = format
    return formatter.string(from: timestamp)
}

func toIntervalString(from interval: TimeInterval) -> String {
    let formatter = DateComponentsFormatter()
    formatter.unitsStyle = .abbreviated
    formatter.allowedUnits = [.day, .hour, .minute]
    return formatter.string(from: interval) ?? ""
}
