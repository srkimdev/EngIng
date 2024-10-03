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
                    Image(systemName: "house")
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
                        Text("Study")
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
            
//            Spacer()
//            
//            Button {
//                selected = .user
//            } label: {
//                VStack(alignment: .center) {
//                    Image(systemName: "person")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 22)
//                    if selected == .user {
//                        Text("User")
//                            .font(.system(size: 11))
//                    }
//                }
//            }
//            .foregroundStyle(selected == .user ? Color.accentColor : Color.primary)
            
            
        }
        .padding()
        .frame(height: 64)
        .background {
            RoundedRectangle(cornerRadius: 36)
                .fill(Color.white)
                .shadow(color: .black.opacity(0.15), radius: 8, y: 2)
        }
        .padding([.horizontal, .bottom])
        
    }
    
}

//#Preview {
//    CustomTabView(selectedTab: )
//}
