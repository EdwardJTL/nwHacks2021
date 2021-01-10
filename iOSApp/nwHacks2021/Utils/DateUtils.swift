//
//  DateUtils.swift
//  nwHacks2021
//
//  Created by Edward Luo on 2021-01-09.
//

import Foundation

func toDateString(from timestamp: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "y-MMM-d"
    return formatter.string(from: timestamp)
}
