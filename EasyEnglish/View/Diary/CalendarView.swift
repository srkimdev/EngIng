//
//  CalendarView.swift
//  EasyEnglish
//
//  Created by 김성률 on 9/12/24.
//

import SwiftUI

struct CalendarView: View {
    
    @State var month: Date = Date()
    @State private var clickedCurrentMonthDates: Date?
    
    init(month: Date, clickedCurrentMonthDates: Date? = nil) {
        _month = State(initialValue: month)
        _clickedCurrentMonthDates = State(initialValue: clickedCurrentMonthDates)
    }
    
    var body: some View {
        
        VStack {
            yearView
            headerView
            calendarGridView
                .padding(.horizontal, 25)
        }
        
    }
    
    //MARK: Year
    private var yearView: some View {
        
        HStack {
            Text(month.getYear)
                .font(.system(size: 18))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 30)
                .padding([.top, .bottom], 5)
            
            Text("연속 7일")
                .font(.system(size: 17))
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.trailing, 30)
                .padding([.top, .bottom], 5)
        }
        
    }
    
    //MARK: Month + Day
    private var headerView: some View {
        
        VStack {
            HStack {
                yearMonthView
            }
            .padding([.horizontal, .bottom])
            
            HStack {
                ForEach(Self.weekdaySymbols.indices, id: \.self) { symbol in
                    Text(Self.weekdaySymbols[symbol].uppercased())
                        .foregroundStyle(.gray)
                        .frame(maxWidth: .infinity)
                }
            }
            .padding(.horizontal, 25)
        }
        
    }
    
    //MARK: Month
    private var yearMonthView: some View {
        
        HStack(alignment: .center) {
            
            Button(action: {
                changeMonth(by: -1)
            }, label: {
                Image(systemName: "chevron.left")
                    .font(.title2)
                    .foregroundStyle(.black) // change
            })
            
            Spacer()
            
            Text(month.getMonth) // change
                .font(.title2.bold())
            
            Spacer()
            
            Button(action: {
                changeMonth(by: 1)
            }, label: {
                Image(systemName: "chevron.right")
                    .font(.title2)
                    .foregroundStyle(.black) // change
            })
            
        }
        .padding(.horizontal)
        
    }
    
    //MARK: Grid
    private var calendarGridView: some View {
        let daysInMonth: Int = numberOfDays(in: month)
        let firstWeekday: Int = firstWeekdayOfMonth(in: month) - 1
        let lastDayOfMonthBefore = numberOfDays(in: previousMonth())
        let numberOfRows = Int(ceil(Double(daysInMonth + firstWeekday) / 7.0))
        let visibleDaysOfNextMonth = numberOfRows * 7 - (daysInMonth + firstWeekday)
        
        return LazyVGrid(columns: Array(repeating: GridItem(), count: 7)) {
            
            ForEach(-firstWeekday ..< daysInMonth + visibleDaysOfNextMonth, id: \.self) { index in
                
                Group {
                    if index > -1 && index < daysInMonth {
                        let date = getDate(for: index)
                        let day = Calendar.current.component(.day, from: date)
                        let clicked = clickedCurrentMonthDates == date
                        let isToday = date.formattedCalendarDayDate == today.formattedCalendarDayDate
                        
                        CellView(day: day, clicked: clicked, isToday: isToday)
                        
                    } else if let prevMonthDate = Calendar.current.date(byAdding: .day, value: index + lastDayOfMonthBefore, to: previousMonth()) {
                        
                        let day = Calendar.current.component(.day, from: prevMonthDate)
                        
                        CellView(day: day, isCurrentMonthDay: false)
                        
                    }
                }
                .onTapGesture {
                    if 0 <= index && index < daysInMonth {
                        let date = getDate(for: index)
                        clickedCurrentMonthDates = date
                    }
                }
                
            }
            
        }
        
    }
    
}

private struct CellView: View {
    
    private var day: Int
    private var clicked: Bool
    private var isToday: Bool
    private var isCurrentMonthDay: Bool
    private var textColor: Color {
        if clicked {
            return Color.white
        } else if isCurrentMonthDay {
            return Color.black
        } else {
            return Color.gray
        }
    }
    private var backgroundColor: Color {
        if clicked {
            return Color.black
        } else if isToday {
            return Color.gray
        } else {
            return Color.white
        }
    }
    
    fileprivate init(day: Int, clicked: Bool = false, isToday: Bool = false, isCurrentMonthDay: Bool = true) {
        self.day = day
        self.clicked = clicked
        self.isToday = isToday
        self.isCurrentMonthDay = isCurrentMonthDay
    }
    
    fileprivate var body: some View {
        
        VStack {
            Circle()
                .fill(backgroundColor)
                .overlay(Text(String(day)))
                .foregroundStyle(textColor)
        }
        .frame(height: 30)
        
    }
    
}



#Preview {
    CalendarView(month: Date())
}
