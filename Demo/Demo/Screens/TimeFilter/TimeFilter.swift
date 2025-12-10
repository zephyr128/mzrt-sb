//
//  TimeFilter.swift
//  Demo
//
//  Created by Nenad Prahovljanovic on 8. 12. 2025..
//

import Foundation

enum TimeFilter: String, CaseIterable, Hashable {
    case today
    case tomorrow
    case weekend
    case nextWeek
    case all
    

    var localizedName: String {
        switch self {
        case .today: return "Danas"
        case .tomorrow: return "Sutra"
        case .weekend: return "Vikend"
        case .nextWeek: return "Sledeća nedelja"
        case .all: return "Sve"
        }
    }

    func matches(date: Date, calendar: Calendar = .current) -> Bool {
        switch self {
        case .today:
            return calendar.isDateInToday(date)
        case .tomorrow:
            return calendar.isDateInTomorrow(date)
        case .weekend:
            let nextSaturday = calendar.nextDate(
                after: Date(),
                matching: DateComponents(weekday: 7),
                matchingPolicy: .nextTimePreservingSmallerComponents
            )!
            let nextSunday = calendar.date(byAdding: .day, value: 1, to: nextSaturday)!
            return calendar.isDate(date, inSameDayAs: nextSaturday)
                || calendar.isDate(date, inSameDayAs: nextSunday)
        case .nextWeek:
            guard let thisWeek = calendar.dateInterval(of: .weekOfYear, for: Date()) else { return false }
            let nextWeekStart = thisWeek.end
            guard let nextWeekEnd = calendar.date(byAdding: .weekOfYear, value: 1, to: nextWeekStart) else { return false }
            return date >= nextWeekStart && date < nextWeekEnd
        case .all:
            return true
        }
    }
}
