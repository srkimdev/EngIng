//
//  CustomTabView.swift
//  EasyEnglish
//
//  Created by 김성률 on 9/13/24.
//

import SwiftUI

struct CustomTabView: View {
    
    @Binding var selectedTab: Tab
    
    var body: some View {
        
        HStack {
            
            Spacer()
            
            Button(action: {
                selectedTab = .home
            }, label: {
                Image(systemName: selectedTab == .home ? "eraser" : "eraser.fill")
                        .font(.title2)
                        .foregroundStyle(.black)
            })
            
            Spacer()
            
            Button(action: {
                selectedTab = .save
            }, label: {
                Image(systemName: selectedTab == .save ? "house" : "house.fill")
                        .font(.title2)
                        .foregroundStyle(.black)
            })
            
            Spacer()
            
            Button(action: {
                selectedTab = .diary
            }, label: {
                Image(systemName: selectedTab == .diary ? "book" : "book.fill")
                        .font(.title2)
                        .foregroundStyle(.black)
            })/*selectedTab: <#Binding<Tab>#>*/
            
            Spacer()
            
        }
        
    }
    
}

//#Preview {
//    CustomTabView()
//}
