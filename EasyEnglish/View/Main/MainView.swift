//
//  MainView.swift
//  EasyEnglish
//
//  Created by 김성률 on 9/15/24.
//

import SwiftUI
import Charts

struct MainView: View {
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                
                VStack(spacing: 0) {
                    Rectangle()
                        .fill(.orange.opacity(0.2))
                    Rectangle()
                        .fill(Colors.backgroundColor)
                }
                
                mainView()
                
            }
            
        
//            ZStack {
//                Colors.backgroundColor
//                    .ignoresSafeArea()
//                
//                ScrollView {
//                    
//                    Text("Example")
//                    
//                    circle3ChartView()
//                    button3View()
//                    recent7daysChart()
//                    
//                }
//            }
//            .navigationTitle("오늘의 학습")
//            .toolbar {
//                ToolbarItem(placement: .topBarTrailing) {
//                    NavigationLink{
//                        DiaryCalendarView()
//                    } label: {
//                        Image(systemName: "calendar")
//                            .foregroundStyle(.black)
//                    }
//                }
//            }
//            
        }
        
    }

    func mainView() -> some View {
        
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                
                Text("Hi Octavia, \nthis is your study")
                    .font(.title)
    //                .foregroundStyle(.white)
                
                RoundedRectangle(cornerRadius: 20)
                    .fill(.white.opacity(0.7))
                    .frame(height: geometry.size.height / 10)
                
                Spacer()
                    .frame(height: geometry.size.height / 5)
                
                RoundedRectangle(cornerRadius: 20)
                    .fill(.black.opacity(0.2))
                    .frame(height: geometry.size.height / 4, alignment: .center)
                    
                Spacer()
                    
            }
        }
        .padding(25)
//        .frame(maxHeight: .infinity)
 
    }
    
    func circle3ChartView() -> some View {
        
        RoundedRectangle(cornerRadius: 15)
//            .fill(.black)
            .frame(height: Constants.screenHeight / 5.5)
            .overlay {
                
                HStack {
                    VStack {
                        Text("goal reached")
                            .font(.system(size: 20).bold())
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Spacer()
                        
                        Text("총 7일 연속")
                            .font(.system(size: 20))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.vertical, 25)
                    
                    CircleChartView()
                }
                .padding(.horizontal, 25)

            }
            .padding(.horizontal, 16)
        
    }
    
    func button3View() -> some View {
        
        RoundedRectangle(cornerRadius: 15)
//            .fill(.white)
            .overlay {
                
                VStack {
                    Text("Your Section")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 25)
                        .padding(.bottom, 10)
                        .font(.system(size: 20).bold())
                    
                    HStack {
                        ForEach(Sections.allCases, id: \.self) { item in
                            buttonRowView(item)
                        }
                    }
                }
                
            }
            .frame(height: Constants.screenHeight / 4.5)
            .padding()
        
    }
    
    func buttonRowView(_ vc: Sections) -> some View {
        
        VStack {
            
            NavigationLink {
                vc.showVC
            } label: {
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: (Constants.screenWidth - 180) / 3, height: (Constants.screenWidth - 180) / 3)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 5)
                    .overlay {
//                        Image(vc.images)
//                            .resizable()
//                            .aspectRatio(contentMode: .fit)
//                            .frame(width: 40, height: 40)
                    }
            }
            
            Text(vc.rawValue)
            
        }
    
    }
    
    func recent7daysChart() -> some View {
        
        RoundedRectangle(cornerRadius: 10)
            .fill(.white)
            .overlay {
                
                VStack {
                    Text("최근 7일간 학습 진도")
                        .font(.system(size: 20).bold())
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 25)
                        .padding(.bottom, 20)
                    
                    WeekChartView()
                        .frame(height: 180)
                        .padding(.horizontal, 25)
                    
                }
                
            }
            .frame(height: Constants.screenHeight / 3)
            .padding(.horizontal)
        
    }
    
}



#Preview {
    MainView()
}
