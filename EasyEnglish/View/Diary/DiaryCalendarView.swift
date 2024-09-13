//
//  DiaryCalendarView.swift
//  EasyEnglish
//
//  Created by 김성률 on 9/12/24.
//

import SwiftUI

struct DiaryCalendarView: View {
    var body: some View {
        
        NavigationView {
            ScrollView {
                VStack {
                    CalendarView(month: Date())
                    todayDiary
                    DiaryRowView()
                    
//                    Spacer()
                    
                }
            }
        }
        
    }
    
    private var todayDiary: some View {
        
        Text("Today's Diary")
            .font(.title2.bold())
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding([.horizontal, .top], 20)
        
    }
    
}

struct DiaryRowView: View {
    
    var body: some View {
        
        Rectangle()
            .padding(.horizontal, 20)
//            .padding(.bottom, 30)
//            .clipShape(RoundedRectangle(cornerRadius: 20))
            
        
    }
    
    
}


#Preview {
    DiaryCalendarView()
}
