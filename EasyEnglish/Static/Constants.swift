//
//  Constants.swift
//  EasyEnglish
//
//  Created by 김성률 on 9/13/24.
//

import Foundation
import SwiftUI

struct Constants {
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height
    
    
}

enum Colors {
    
//    static let backgroundColor = #colorLiteral(red: 0.9812712073, green: 0.976305306, blue: 0.9936047196, alpha: 1)
    static let backgroundColor = Color(red: 0.9812712073, green: 0.976305306, blue: 0.9936047196)
    
}

enum Sections: String, CaseIterable {
    case solveProblem = "학습 하기"
    case savedProblem = "복습 하기"
    case writeDiary = "일기 쓰기"
    
    var images: String {
        switch self {
        case .solveProblem:
            return "UserSpeakLinear"
        case .savedProblem:
            return ""
        case .writeDiary:
            return ""
        }
    }
    
    @ViewBuilder
    var showVC: some View {
        switch self {
        case .solveProblem:
            ProblemListView()
        case .savedProblem:
            SaveProblemView()
        case .writeDiary:
            DiaryWriteView()
        }
    }
    
}
