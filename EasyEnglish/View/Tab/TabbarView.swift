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
    case user
}

struct TabbarView: View {
    
    @State private var selected: Tab = .main
    
    // configurewithtransparent
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                TabView(selection: $selected) {
                    Group {
                        MainView()
                            .tag(Tab.main)
                        
                        ProblemListView()
                            .tag(Tab.problem)
                    
                        DiaryCalendarView()
                            .tag(Tab.diary)
                        
                        UserSettingView()
                            .tag(Tab.user)
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
    
}

#Preview {
    TabbarView()
}
