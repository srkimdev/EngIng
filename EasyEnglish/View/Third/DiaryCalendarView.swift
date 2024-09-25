//
//  DiaryCalendarView.swift
//  EasyEnglish
//
//  Created by 김성률 on 9/12/24.
//

import SwiftUI

struct DiaryCalendarView: View {
    
    @StateObject private var viewModel = DiaryCalendarViewModel()
    @State var date: Date = Date()
    
    var body: some View {
        
        GeometryReader { geometry in
            
            //MARK: Background
            Rectangle()
                .fill(.orange.opacity(0.2))
                .frame(height: geometry.size.height / 3.7)
            
            //MARK: Main
            VStack {
                
                Spacer()
                
                RoundedRectangle(cornerRadius: 25)
                    .fill(Colors.backgroundColor)
                    .frame(height: geometry.size.height * 3 / 4)
                    .overlay {
                        ScrollView {
                            //                            mainView(geometry: geometry)
                        }
                    }
                
            }
            
            VStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.white)
                    .overlay {
                        CalendarView(month: Date())
                            .environmentObject(viewModel)
                            .padding(20)
                    }
                    .frame(height: geometry.size.height / 2.3)
                    .padding(.bottom, 20)
                
                todayDiary
                
                DiaryRowView(diary: $viewModel.output.showDiary)
                
            }
            .padding(30)

        }
        
    }
    
    private var todayDiary: some View {
        
        Text("Today's Diary")
            .font(.title2.bold())
            .frame(maxWidth: .infinity, alignment: .leading)
        
    }
    
}

struct DiaryRowView: View {
    
    @Binding var diary: DiaryTable
    
    var body: some View {
        
        NavigationLink {
            DiaryReviseView()
        } label: {
            RoundedRectangle(cornerRadius: 10)
                .fill(.orange.opacity(0.2))
                .frame(width: Constants.screenWidth - 50, height: 100)
                .overlay {
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text(diary.title)
                                .foregroundStyle(.black)
                            Spacer()
                            Text(diary.content)
                                .foregroundStyle(.black)
                        }
                        .padding(.leading, 20)
                        .padding(.vertical, 30)
                        
                        Spacer()
                        
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.white)
                            .frame(width: 80, height: 80)
                            
                    }
                    .padding(.horizontal, 10)
                    
                }
            
        }
        
    }
    
}

#Preview {
    DiaryCalendarView()
}
