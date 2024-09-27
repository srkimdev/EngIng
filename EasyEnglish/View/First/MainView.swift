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
            
            //MARK: Profile
            Rectangle()
                .fill(.orange.opacity(0.2))
                .frame(height: geometry.size.height / 3.7)
                .overlay {
                    profileView(geometry: geometry)
                        .padding(25)
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
                    }
                
            }
                
        }
        .onAppear {
            viewModel.input.attendanceCheck.send()
        }

    }
    
    //MARK: Profile
    func profileView(geometry: GeometryProxy) -> some View {
        
        HStack {
            
            LottieView(animation: .named("Animation - 1727267547779"))
                .looping()
                .frame(width: geometry.size.width / 3, height: geometry.size.width / 3)
            
            Spacer()
            
            Text("Hi Octavia, \nthis is your study")
            
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
            
            RoundedRectangle(cornerRadius: 20)
                .fill(.white)
                .frame(height: geometry.size.height / 4)
                .overlay {
                    
                    HStack {
                        Spacer()
                        CircleChartView()
                            .frame(width: geometry.size.width / 3, height: geometry.size.width / 3)
                    }
                    .padding(.horizontal, 25)
                    
                }
                .padding(.bottom, 20)
            
//            button3View()
//                .frame(height: geometry.size.height / 5)
            
            Text("Recent 7 days study")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.title2)
            
            recent7daysChart()
                .frame(height: geometry.size.height / 3)
                .padding(.bottom, 60)
            
        }
        .padding(25)
 
    }
    
    func daysCircle7View() -> some View {
        
        HStack {
            ForEach(0..<7) { index in
                Circle()
                    .fill(/*viewModel.attendances[index].isChecked ? Color.green : Color.gray*/Color.gray)
                    .frame(width: 40, height: 40)
                    .overlay(Text("월").foregroundColor(.white))
            }
        }
        
    }
    
//    func circle3ChartView() -> some View {
//        
//        RoundedRectangle(cornerRadius: 15)
////            .fill(.black)
//            .frame(height: Constants.screenHeight / 5.5)
//            .overlay {
//                
//                HStack {
//                    VStack {
//                        Text("goal reached")
//                            .font(.system(size: 20).bold())
//                            .frame(maxWidth: .infinity, alignment: .leading)
//                        
//                        Spacer()
//
//                        Text("총 7일 연속")
//                            .font(.system(size: 20))
//                            .frame(maxWidth: .infinity, alignment: .leading)
//                    }
//                    .padding(.vertical, 25)
//                    
//                    CircleChartView()
//                }
//                .padding(.horizontal, 25)
//
//            }
//            .padding(.horizontal, 16)
//        
//    }
    
    func button3View() -> some View {
    
        HStack {
            ForEach(Sections.allCases, id: \.self) { item in
                buttonRowView(item)
            }
        }
        
    }
    
    func buttonRowView(_ vc: Sections) -> some View {
        
        VStack {
            
            NavigationLink {
                vc.showVC
            } label: {
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: (Constants.screenWidth - 180) / 3, height: (Constants.screenWidth - 180) / 3)
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
        .padding(.horizontal, 20)
    
    }
    
    func recent7daysChart() -> some View {
        
        RoundedRectangle(cornerRadius: 10)
            .fill(.white)
            .overlay {
                
                VStack {
                    WeekChartView()
                }
                .padding(20)
                
            }
        
    }
    
}

//#Preview {
//    MainView()
//}


