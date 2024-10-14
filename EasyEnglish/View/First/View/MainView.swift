//
//  MainView.swift
//  EasyEnglish
//
//  Created by 김성률 on 9/15/24.
//

import SwiftUI
import Charts
import Lottie

struct MainView: View {
    
    @StateObject var viewModel = AttendanceViewModel()
    
    var body: some View {
        
        GeometryReader { geometry in
            
            let _ = print(geometry.size)
            
            //MARK: Profile
            Rectangle()
                .fill(.orange.opacity(0.2))
                .frame(height: geometry.size.height / 3.7)
                .overlay {
                    profileView(geometry: geometry)
                        .padding(20)
                }
            
            //MARK: Main
            VStack {

                Spacer()

                RoundedRectangle(cornerRadius: 25)
                    .fill(Colors.backgroundColor)
                    .frame(height: geometry.size.height * 3 / 4)
                    .overlay {
                        ScrollView {
                            mainView(geometry: geometry)
                        }
                        .scrollIndicators(.hidden)
                    }
                
            }
                
        }
        .onAppear {
            viewModel.input.attendanceCheck.send()
            viewModel.input.showSavedSentenceCount.send()
            viewModel.input.showSolvedSentenceCount.send()
        }

    }
    
    //MARK: Profile
    func profileView(geometry: GeometryProxy) -> some View {
        
        HStack {
            
            LottieView(animation: .named("Animation - 1727267547779"))
                .looping()
                .frame(width: geometry.size.width / 3, height: geometry.size.width / 3)
            
            RoundedRectangle(cornerRadius: 20)
                .fill(.white)
                .frame(height: geometry.size.height / 6)
                .overlay {
                    
                    HStack {
                        VStack {
                            Text("해결한 문제")
                                .font(.system(size: 13))
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(red: 249/255, green: 192/255, blue: 12/255).opacity(0.5))
                                .frame(width: geometry.size.width / 6, height: geometry.size.width / 10)
                                .overlay {
                                    Text("\(viewModel.output.solvedSentenceCount)개")
                                }
                        }
                        
                        Spacer()
                        CircleChartView(
                            solved: $viewModel.output.solvedSentenceCount,
                            total: $viewModel.output.solvedTotalCount
                        )
                            .frame(width: geometry.size.width / 5, height: geometry.size.width / 5)
                    }
                    .padding(.horizontal, 20)
                    
                }
                .padding(.bottom, 20)
            
        }

    }

    //MARK: Main
    func mainView(geometry: GeometryProxy) -> some View {
        
        VStack {
            
            RoundedRectangle(cornerRadius: 20)
                .fill(.white.opacity(0.7))
                .frame(height: geometry.size.height / 15)
                .overlay {
                    daysCircle7View()
                }
                .padding(.bottom, 20)
            
            NavigationLink {
                SaveProblemView()
            } label: {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.white.opacity(0.7))
                    .frame(height: geometry.size.height / 12)
                    .overlay {
                        HStack {
                            Image(systemName: "book")
                                .foregroundStyle(.black)
                            Text("저장한 문장 학습하기")
                                .foregroundStyle(.black)
                            Spacer()
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.orange.opacity(0.2))
                                .overlay {
                                    Text("\(viewModel.output.savedSentenceCount)")
                                        .foregroundStyle(.black)
                                }
                                .frame(width: geometry.size.width / 12, height: geometry.size.width / 12)
                                
                            Image(systemName: "chevron.right")
                                .foregroundStyle(.black)
                        }
                        .padding()
                    }
            }
            .padding(.bottom, 20)

            Text("Recent 7 days study")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.title2)
            
            recent7daysChart(viewModel.output.weekDate)
                .frame(height: geometry.size.height / 3)
                .padding(.bottom, 60)
            
        }
        .padding(25)
 
    }
    
    func daysCircle7View() -> some View {
        
        HStack {
            ForEach(0..<7) { index in
                Circle()
                    .fill(viewModel.output.weekDate[index].isAttended ? Color.brown.opacity(0.5) : Color.gray)
                    .frame(width: 40, height: 40)
                    .overlay {
                        Text(DateFormatManager.shared.getDayOfWeek(from: viewModel.output.weekDate[index].date))
                            .foregroundColor(viewModel.output.weekDate[index].isAttended ? .black : Color.white)
                    }
            }
        }
        
    }
    
    func recent7daysChart(_ weekList: [DayTable]) -> some View {
        
        RoundedRectangle(cornerRadius: 10)
            .fill(.white)
            .overlay {
                VStack {
                    WeekChartView(weekList: weekList)
                }
                .padding(20)
            }
        
    }
    
}

#Preview {
    MainView()
}


