//
//  AttendanceViewModel.swift
//  EasyEnglish
//
//  Created by 김성률 on 9/24/24.
//

import Foundation

struct Attendance: Identifiable {
    let id = UUID()
    let day: String
    var isChecked: Bool
}

class AttendanceViewModel: ObservableObject {
    
    @Published var attendances: [Attendance] = [
        Attendance(day: "일", isChecked: false),
        Attendance(day: "월", isChecked: true),
        Attendance(day: "화", isChecked: false),
        Attendance(day: "수", isChecked: false),
        Attendance(day: "목", isChecked: false),
        Attendance(day: "금", isChecked: false),
        Attendance(day: "토", isChecked: false),
    ]
    
    func toggleAttendance(for index: Int) {
        attendances[index].isChecked.toggle()
    }
    
    func resetAttendanceIfNeeded() {
        let calendar = Calendar.current
        let currentWeekday = calendar.component(.weekday, from: Date())
        // 1 ± 7 -> 일 ± 토
        
        print(currentWeekday)
        
        // 만약 주의 첫 날(일요일)인 경우 출석 리셋
        if currentWeekday == 1 {
            for index in attendances.indices {
                attendances[index].isChecked = false
            }
        }
        
        attendances[currentWeekday - 1].isChecked = true

    }
}
