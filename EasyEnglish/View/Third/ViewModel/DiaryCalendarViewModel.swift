//
//  DiaryCalendarViewModel.swift
//  EasyEnglish
//
//  Created by 김성률 on 9/25/24.
//

import Foundation
import Combine
import RealmSwift

final class DiaryCalendarViewModel: ObservableObject {
    
    var cancellables = Set<AnyCancellable>()
    var input = Input()
    @Published var output = Output()
    
    let repository = RealmRepository<DiaryTable>()
    
    struct Input {
        let selectedDate = PassthroughSubject<Date, Never>()
    }
    
    struct Output {
        var showDiary: DiaryTable?
    }
    
    init() {
        
        input.selectedDate
            .sink { value in
                self.output.showDiary = self.readDiary(for: value)
            }
            .store(in: &cancellables)
        
    }
    
    func readDiary(for date: Date) -> DiaryTable? {
        let startOfDay = Calendar.current.startOfDay(for: date)
        let endOfDay = Calendar.current.date(byAdding: .day, value: 1, to: startOfDay)!
        
        let result = repository.readAllItem().first { diary in
            return diary.date >= startOfDay && diary.date < endOfDay
        }
        
        return result
    }
    
}
