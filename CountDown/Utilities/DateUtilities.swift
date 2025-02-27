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

/// Allows the day, month, and year components to be extracted from a Date object
///
/// Taken from the following source:
/// https://stackoverflow.com/questions/53356392/how-to-get-day-and-month-from-date-type-swift-4
extension Date {
    /// Returns the given components of the Date
    ///
    /// Example usage: let components = date.get(.day, .month, .year)
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }
    
    /// Returns the given components of the Date
    ///
    /// Example usage: let component = date.get(.day)
    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
}

/// Returns a string of the given date formatted by the user's locale
/// - Parameter date: The date to convert to a string
func dateDiffInDays(from date: Date) -> Int {
    return abs(date.daysFromToday)
}

/// Returns a string representing the number of days ago in days, months, or years
func dateDiffString(daysAgo: Int) -> String {    
    switch daysAgo {
    case 0: return "Today"
    case 1: return "1 day ago"
    case 1..<30: return "\(daysAgo) days ago"
    case 30..<60: return "1 month ago"
    case 60..<365: return "\(daysAgo / 30) months ago"
    case 365: return "1 year ago"
    default: return "1+ years ago"
    }
}
