//
//  TabbarView.swift
//  EasyEnglish
//
//  Created by 김성률 on 9/13/24.
//

import SwiftUI

enum Tab {
    case main
    case problem
    case diary
}

struct TabbarView: View {
    
    @State private var selected: Tab = .main
    
    var body: some View {
        
        ZStack {
            TabView(selection: $selected) {
                Group {
                    NavigationStack {
                        MainView()
                    }
                    .tag(Tab.main)
                    
                    NavigationStack {
                        ProblemListView()
                    }
                    .tag(Tab.problem)
                    
                    NavigationStack {
                        DiaryCalendarView()
                    }
                    .tag(Tab.diary)
                }
                .toolbar(.hidden, for: .tabBar)
                
                
            }
            
            VStack {
                Spacer()
                CustomTabView(selected: $selected)
            }
        }
        
    }
    
}

#Preview {
    TabbarView()
}
