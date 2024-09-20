//
//  CustomTabView.swift
//  EasyEnglish
//
//  Created by 김성률 on 9/13/24.
//

import SwiftUI

struct CustomTabView: View {
    
    @Binding var selected: Tab
    
    var body: some View {
        
        HStack {
            Spacer()
            
            Button {
                selected = .main
            } label: {
                VStack(alignment: .center) {
                    Image(systemName: "star")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 22)
                    if selected == .main {
                        Text("Home")
                            .font(.system(size: 11))
                    }
                }
            }
            .foregroundStyle(selected == .main ? Color.accentColor : Color.primary)
            
            Spacer()
            
            Button {
                selected = .problem
            } label: {
                VStack(alignment: .center) {
                    Image(systemName: "character.book.closed")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 22)
                    if selected == .problem {
                        Text("Review")
                            .font(.system(size: 11))
                    }
                }
            }
            .foregroundStyle(selected == .problem ? Color.accentColor : Color.primary)
            
            Spacer()
            
            Button {
                selected = .diary
            } label: {
                VStack(alignment: .center) {
                    Image(systemName: "apple.meditate")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 22)
                    if selected == .diary {
                        Text("Diary")
                            .font(.system(size: 11))
                    }
                }
            }
            .foregroundStyle(selected == .diary ? Color.accentColor : Color.primary)
            
            Spacer()
            
        }
        .padding()
        .frame(height: 72)
        .background {
            RoundedRectangle(cornerRadius: 36)
                .fill(Color.white)
                .shadow(color: .black.opacity(0.15), radius: 8, y: 2)
        }
        .padding(.horizontal)
        
    }
    
}

//#Preview {
//    CustomTabView(selectedTab: )
//}


//RoundedRectangle(cornerRadius: 30)
//    .fill(.white)
//    .frame(height: 60)
//    .padding(30)


//        ZStack {
    
    
    
//            HStack {
//
//                Spacer()
//
//                Button(action: {
//                    selectedTab = .home
//                }, label: {
//                    Image(systemName: selectedTab == .home ? "eraser" : "eraser.fill")
//                            .font(.title2)
//                            .foregroundStyle(.black)
//                })
//
//                Spacer()
//
//                Button(action: {
//                    selectedTab = .save
//                }, label: {
//                    Image(systemName: selectedTab == .save ? "house" : "house.fill")
//                            .font(.title2)
//                            .foregroundStyle(.black)
//                })
//
//                Spacer()
//
//                Button(action: {
//                    selectedTab = .diary
//                }, label: {
//                    Image(systemName: selectedTab == .diary ? "book" : "book.fill")
//                            .font(.title2)
//                            .foregroundStyle(.black)
//                })
//
//                Spacer()
//
//            }
    
//        }
//        .padding(20)
