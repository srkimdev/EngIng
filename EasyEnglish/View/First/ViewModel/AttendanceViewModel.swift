//
//  AttendanceViewModel.swift
//  EasyEnglish
//
//  Created by 김성률 on 9/24/24.
//

import Foundation
import RealmSwift
import Combine

final class AttendanceViewModel: ObservableObject {
    
    var cancellables = Set<AnyCancellable>()
    let input = Input()
    @Published var output = Output()
    
    let repository = RealmRepository<DayTable>()
    
    @ObservedResults(SentenceTable.self) var sentences
    
    struct Input {
        let attendanceCheck = PassthroughSubject<Void, Never>()
        let showSavedSentenceCount = PassthroughSubject<Void, Never>()
    }
    
    struct Output {
        var savedSentenceCount = 0
        var weekDate: [DayTable] = []
    }
    
    init() {
        
        if repository.readAllItem().isEmpty {
            saveNextWeekDays(from: Date())
        }
        
        loadAttendance(for: Date())
        
        input.attendanceCheck
            .sink { [weak self] _ in
                guard let self else { return }
                
                checkAttendance(Date())
    
            }
            .store(in: &cancellables)
        
        input.showSavedSentenceCount
            .sink { [weak self] _ in
                guard let self else { return }
                output.savedSentenceCount = sentences.filter { $0.isLike == true }.count
            }
            .store(in: &cancellables)
        
    }
    
    func saveNextWeekDays(from date: Date) {
        let calendar = Calendar.current
        
        for i in -7..<365 {
            let currentDate = calendar.date(byAdding: .day, value: i, to: date)!
            let dayEntry = DayTable()
            dayEntry.date = currentDate

            repository.createItem(dayEntry)
        }
    }
    
    func checkAttendance(_ date: Date) {
        let calendar = Calendar.current
        
        let savedDays = repository.readAllItem()
        let matchingDays = savedDays.filter {
            calendar.isDate($0.date, inSameDayAs: date)
        }
        
        if let matchingDay = matchingDays.first {
            repository.updateItem(primaryKey: matchingDay.id) { value in
                value.isAttended = true
            }
        }
        
    }

    func loadAttendance(for date: Date) {
        
        let calendar = Calendar.current
        let weekStart = calendar.date(byAdding: .day, value: -calendar.component(.weekday, from: date) + 1, to: date)!
        
        output.weekDate = fetchDays(from: weekStart)
        
    }
    
    func fetchDays(from startDate: Date) -> [DayTable] {
        let calendar = Calendar.current
        
        guard let endDate = calendar.date(byAdding: .day, value: 7, to: startDate) else {
            return []
        }
        
        let savedDays = repository.readAllItem().filter("date >= %@ AND date < %@", startDate, endDate)

        print(savedDays)
        return Array(savedDays)
    }
    
}
