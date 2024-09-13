//
//  Date+.swift
//  EasyEnglish
//
//  Created by 김성률 on 9/13/24.
//

import Foundation

extension Date {
    
    //MARK: Get MMMM string
    static let getMonthFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        return formatter
    }()
      
    var getMonth: String {
        return Date.getMonthFormatter.string(from: self)
    }
    
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
