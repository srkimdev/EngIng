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
    
    func dateToyyyyMMdd(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let formattedDate = dateFormatter.string(from: date)
        return formattedDate
    }
    
}

