//
//  DateFormatManager.swift
//  EasyEnglish
//
//  Created by 김성률 on 9/26/24.
//

import Foundation

final class DateFormatManager {
    
    static let shared = DateFormatManager()
    
    private init() { }
    
    //MARK: day, date, month, year
    func ddmy(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE dd, MMMM yyyy"
        dateFormatter.locale = Locale(identifier: "en_US")
        
        let formattedDate = dateFormatter.string(from: date)
        return formattedDate
    }
    
    //MARK: get day "월"
    func getDayOfWeek(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E"
        
        let dayOfWeek = dateFormatter.string(from: date)
        
        switch dayOfWeek {
        case "Mon":
            return "월"
        case "Tue":
            return "화"
        case "Wed":
            return "수"
        case "Thu":
            return "목"
        case "Fri":
            return "금"
        case "Sat":
            return "토"
        case "Sun":
            return "일"
        default:
            return ""
        }
    }
    
}

