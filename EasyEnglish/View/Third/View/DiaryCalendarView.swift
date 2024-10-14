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
            let _ = print(geometry.size)
            
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
                
            }
            
            VStack {

                RoundedRectangle(cornerRadius: 20)
                    .fill(.white)
                    .overlay {
                        CalendarView(month: Date())
                            .environmentObject(viewModel)
                            .padding(20)
                    }
                    .frame(height: 300)
                    .padding(.bottom, 20)
                
                todayDiary
                
                DiaryRowView(diary: $viewModel.output.showDiary)

                Spacer()
                
                writeButtonView(geometry)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.bottom, 70)
            }
            .padding(30)

        }
        .onAppear {
            viewModel.input.selectedDate.send(Date())
        }
        
    }
    
    private var todayDiary: some View {
        
        Text("Today's Diary")
            .font(.title2.bold())
            .frame(maxWidth: .infinity, alignment: .leading)
        
    }
    
    func writeButtonView(_ geometry: GeometryProxy) -> some View {
        
        NavigationLink {
            DiaryWriteView()
        } label: {
            Circle()
                .fill(.orange.opacity(0.2))
                .overlay {
                    Image(systemName: "plus")
                        .foregroundStyle(.white)
                }
        }
        .frame(width: 40, height: 40)

    }
    
}

struct DiaryRowView: View {
    
    @Binding var diary: DiaryTable?
    
    var body: some View {
        
        if let diary {
            NavigationLink {
                DiaryReviseView(diary: diary)
            } label: {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.orange.opacity(0.2))
                    .frame(height: 100)
                    .overlay {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(diary.title)
                                    .foregroundStyle(.black)
                                Spacer()
                                Text(diary.content)
                                    .foregroundStyle(.black)
                            }
                            .padding(.vertical, 20)
                            .padding(.horizontal, 20)
                            
                            Spacer()
                            
                            RoundedRectangle(cornerRadius: 10)
                                .overlay {
                                    if let uiImage = FilesManager.shared.loadImageToDocument(filename: DateFormatManager.shared.getyymmdd(diary.date)) {
                                        Image(uiImage: uiImage)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 80, height: 80)
                                            .clipShape(RoundedRectangle(cornerRadius: 10))
                                    }
                                }
                                .frame(width: 80, height: 80)
                            
                        }
                        .padding(.horizontal, 10)
                    }
            }
        } else {
            RoundedRectangle(cornerRadius: 10)
                .fill(.orange.opacity(0.2))
                .frame(height: 100)
                .overlay {
                    Text("일기가 없습니다.")
                }
        }
        
    }
    
}

#Preview {
    DiaryCalendarView()
}
