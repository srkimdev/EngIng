//
//  TabbarView.swift
//  EasyEnglish
//
//  Created by 김성률 on 9/13/24.
//

import SwiftUI

enum Tab {
    case home
    case save
    case diary
}

struct TabbarView: View {
    
    @State var selectedTab: Tab = .home
    
    var body: some View {
        
        VStack {
            
            Spacer()
            
            switch selectedTab {
            case .home:
                ProblemListView()
            case .save:
                SaveProblemView()
            case .diary:
                DiaryCalendarView()
            }
            
            Spacer()
            
            CustomTabView(selectedTab: $selectedTab)
                .padding(.bottom, 20)
            
        }
        .ignoresSafeArea(.container, edges: .bottom)
        
    }
}

#Preview {
    TabbarView()
}
