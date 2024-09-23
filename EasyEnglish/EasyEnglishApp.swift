//
//  EasyEnglishApp.swift
//  EasyEnglish
//
//  Created by 김성률 on 9/10/24.
//

import SwiftUI

@main
struct EasyEnglishApp: App {
    
    init() {
        checkFirstLaunch()
    }
    
    var body: some Scene {
        WindowGroup {
            TabbarView()
        }
    }
}
