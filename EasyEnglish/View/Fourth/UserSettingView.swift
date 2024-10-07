//
//  UserSettingView.swift
//  EasyEnglish
//
//  Created by 김성률 on 9/20/24.
//

import SwiftUI
import Lottie

struct UserSettingView: View {
    var body: some View {
        
        GeometryReader { geometry in
            let _ = print(geometry.size)
            let _ = print(geometry.safeAreaInsets.top, "safearea")
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
        .navigationTitle("dddd")
        
    }
}

#Preview {
    UserSettingView()
}
