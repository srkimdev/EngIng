//
//  CalendarView+Extension.swift
//  EasyEnglish
//
//  Created by 김성률 on 9/13/24.
//

import SwiftUI

extension CalendarView {
    
    //MARK: Get today
    var today: Date {
        let now = Date()
        let components = Calendar.current.dateComponents([.year, .month, .day], from: now)

        return Calendar.current.date(from: components)!
    }
    
    //MARK: Get Abbreviated days(SAT)
    static let weekdaySymbols: [String] = Calendar.current.shortWeekdaySymbols
    
    //MARK: Get exact date
    func getDate(for index: Int) -> Date {
        
        let calendar = Calendar.current
        guard let firstDayOfMonth = calendar.date(from: DateComponents(year: calendar.component(.year, from: month),
                                                                       month: calendar.component(.month, from: month),
                                                                       day: 1)
        ) else {
            return Date()
        }
        
        var dateComponents = DateComponents()
        dateComponents.day = index
        
        let timeZone = TimeZone.current
        let offset = Double(timeZone.secondsFromGMT(for: firstDayOfMonth))
        dateComponents.second = Int(offset)
        
        let date = calendar.date(byAdding: dateComponents, to: firstDayOfMonth) ?? Date()

        return date
    }
    
    //MARK: Get number of days in the month
    func numberOfDays(in date: Date) -> Int {
        return Calendar.current.range(of: .day, in: .month, for: date)?.count ?? 0
    }
    
    //MARK: Get first day of the month
    func firstWeekdayOfMonth(in date: Date) -> Int {
        let components = Calendar.current.dateComponents([.year, .month], from: date)
        let firstDayOfMonth = Calendar.current.date(from: components)!
        
        return Calendar.current.component(.weekday, from: firstDayOfMonth)
    }
    
    //MARK: Get the last date of the prvious month
    func previousMonth() -> Date {
        let components = Calendar.current.dateComponents([.year, .month], from: month)
        let firstDayOfMonth = Calendar.current.date(from: components)!
        let previousMonth = Calendar.current.date(byAdding: .month, value: -1, to: firstDayOfMonth)!
        
        return previousMonth
    }
    
    //MARK: Get the month you want to change
    func adjustedMonth(by value: Int) -> Date {
        if let newMonth = Calendar.current.date(byAdding: .month, value: value, to: month) {
            return newMonth
        }
        return month
    }
    
    //MARK: Change Month
    func changeMonth(by value: Int) {
        self.month = adjustedMonth(by: value)
    }
    
    //MARK: Check if it's possible to move to the next month
    func canMoveToNextMonth() -> Bool {
        let currentDate = Date()
        let calendar = Calendar.current
        let targetDate = calendar.date(byAdding: .month, value: 3, to: currentDate) ?? currentDate
        
        if adjustedMonth(by: 1) > targetDate {
            return false
        }
        
        return true
    }
    
    //MARK: Check if it's possible to move to the previous month
    func canMoveToPreviousMonth() -> Bool {
        let currentDate = Date()
        let calendar = Calendar.current
        let targetDate = calendar.date(byAdding: .month, value: -3, to: currentDate) ?? currentDate
        
        if adjustedMonth(by: 1) > targetDate {
            return false
        }
        
        return true
    }
    
    
}


