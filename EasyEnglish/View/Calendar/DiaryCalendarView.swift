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
                }
            }
            .navigationTitle("Example")
            .navigationBarTitleDisplayMode(.inline)
        }
        
    }
    
    private var todayDiary: some View {
        
        Text("Today's Diary")
            .font(.title2.bold())
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding([.horizontal, .top], 25)
        
    }
    
}

struct DiaryRowView: View {
    
    var body: some View {
        
        Button(action: {
            print("diary click")
        }, label: {
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.black, lineWidth: 1)
                .frame(width: Constants.screenWidth - 50, height: Constants.screenHeight / 7)
        })
        
    }
    
}


#Preview {
    DiaryCalendarView()
}
