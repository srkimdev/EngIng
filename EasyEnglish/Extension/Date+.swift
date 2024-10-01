//
//  Date+.swift
//  EasyEnglish
//
//  Created by 김성률 on 9/13/24.
//

import Foundation

extension Date {
    
    static let getYearFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter
    }()
      
    var getYear: String {
        return Date.getYearFormatter.string(from: self)
    }
    
    var getMonth: String {
        return Date.getMonthFormatter.string(from: self)
    }
    
    //MARK: Get MMMM string
    static let getMonthFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        return formatter
    }()
    
    //MARK: Get MMMM yyyy dd string
    static let calendarDayDateFormatter: DateFormatter = {
      let formatter = DateFormatter()
      formatter.dateFormat = "MMMM yyyy dd"
      return formatter
    }()
    
    var formattedCalendarDayDate: String {
      return Date.calendarDayDateFormatter.string(from: self)
    }
    
}
