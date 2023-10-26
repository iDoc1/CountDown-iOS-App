//
//  DateUtilities.swift
//  CountDown
//
//  Created by Ian Docherty on 10/22/23.
//

import Foundation

/// These extensions add funcitonality to calculate the number of days between today and a past date
/// Borrowed from the following source:
/// https://stackoverflow.com/questions/72106020/count-days-between-dates-swift-considering-what-may-be-tomorrow

extension Calendar {
    static let iso8601 = Calendar(identifier: .iso8601)
}

extension Date {
    /// From today's noon to self's noon
    /// - Returns: number of days.
    var daysFromToday: Int {
        Calendar.iso8601.dateComponents([.day], from: Date().noon, to: noon).day!
    }
    /// Noon time
    /// - Returns: same date at noon
    var noon: Date {
        Calendar.iso8601.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
}

/// Returns a string of the given date formatted by the user's locale
/// - Parameter date: The date to convert to a string
func dateDiffInDays(from date: Date) -> Int {
    return abs(date.daysFromToday)
}
