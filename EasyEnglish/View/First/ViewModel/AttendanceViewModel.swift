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
    
    let repoWeek = RealmRepository<WeekAttendance>()
    let repoDay = RealmRepository<DayAttendance>()
    
    @ObservedResults(SentenceTable.self) var sentences
    
    struct Input {
        let attendanceCheck = PassthroughSubject<Void, Never>()
        let showSavedSentenceCount = PassthroughSubject<Void, Never>()
    }
    
    struct Output {
        var savedSentenceCount = 0
    }
    
    init() {
        
        
        input.attendanceCheck
            .sink { [weak self] _ in
                self?.setWeek(for: Date())
            }
            .store(in: &cancellables)
        
        input.showSavedSentenceCount
            .sink { [weak self] _ in
                guard let self else { return }
                output.savedSentenceCount = sentences.filter { $0.isLike == true }.count
            }
            .store(in: &cancellables)
        
    }
    
    func setWeek(for date: Date) {
        let calendar = Calendar.current
        let weekStart = calendar.date(byAdding: .day, value: -calendar.component(.weekday, from: date) + 1, to: date)!
        
        let weekEntry = WeekAttendance()
        weekEntry.weekStartDate = weekStart
        
        let dayEntry = DayAttendance()
        
        for i in 0..<7 {
            let currentDate = calendar.date(byAdding: .day, value: i, to: weekStart)!
            dayEntry.date = currentDate
            dayEntry.isAttended = false
            weekEntry.days.append(dayEntry)
        }
        
        repoWeek.createItem(weekEntry)
    }
    
    func loadAttendance() {
        
    }
    
    // 접속하면 그 주의 첫째날부터 마지막날 까지 불러와서 attend만 띄워주기
    // 접속 로직 -> 접속안되있으면 체크, 되있으면 넘어가기
    
}
