//
//  DateUtils.swift
//  Loans-164
//
//  Created by Siarhei Lukyanau on 24.11.25.
//

import Foundation

public class DateUtils {
    public static let calendar = Calendar.current
    
    // Начало текущих суток
    public static var startOfToday: Date {
        return calendar.startOfDay(for: Date())
    }
    
    // Конец текущих суток
    public static var endOfToday: Date {
        let startOfDay = startOfToday
        return calendar.date(byAdding: .day, value: 1, to: startOfDay)!
    }
    
    // Начало текущей недели
    public static var startOfCurrentWeek: Date {
        let components = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date())
        return calendar.date(from: components)!
    }
    
    // Конец текущей недели
    public static var endOfCurrentWeek: Date {
        let startOfWeek = startOfCurrentWeek
        return calendar.date(byAdding: .day, value: 7, to: startOfWeek)!
    }
}
