//
//  AttendanceViewModel.swift
//  EasyEnglish
//
//  Created by 김성률 on 9/24/24.
//

import Foundation
import Combine

final class AttendanceViewModel: ObservableObject {
    
    var cancellables = Set<AnyCancellable>()
    let input = Input()
    @Published var output = Output()
    
    let repository = RealmRepository<WeekTable>()
    
    struct Input {
        let attendanceCheck = PassthroughSubject<Void, Never>()
    }
    
    struct Output {
        
    }
    
    init() {
        
        input.attendanceCheck
            .sink { [weak self] _ in
                self?.checkAttendance()
            }
            .store(in: &cancellables)
        
    }
    
    //MARK: check Attendance
    func checkAttendance() {
        
        let startOfDay = Calendar.current.startOfDay(for: Date())
        let endOfDay = Calendar.current.date(byAdding: .day, value: 1, to: startOfDay)!
        let attendanceRecords = repository.readAllItem().filter("date >= %@ AND date < %@", startOfDay, endOfDay)
        
        if attendanceRecords.isEmpty {
            saveAttendance()
        } else {
            print("Already saved")
        }
    
    }
    
    //MARK: get first date of week
    func startOfWeek(for date: Date) -> Date? {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date)
        
        return calendar.date(from: components)
    }
    
    //MARK: save Attendance
    func saveAttendance() {
        let newRecord = WeekTable()
        newRecord.date = Date()
        
        repository.createItem(newRecord)
    }
    
    //MARK: set 7days list
    func getDatesForWeek(startingFrom date: Date) -> [Date] {
        let calendar = Calendar.current
        var weekDates: [Date] = []
        
        for dayOffset in 0..<7 {
            if let weekDay = calendar.date(byAdding: .day, value: dayOffset, to: date) {
                weekDates.append(weekDay)
            }
        }
        
        return weekDates
    }
    
}
