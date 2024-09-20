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
    
    static let backgroundColor = Color(red: 0.9647058845, green: 0.9647058845, blue: 0.9647058845)
    
}

enum Sections: String, CaseIterable {
    case solveProblem = "학습 하기"
    case savedProblem = "복습 하기"
    case dictionary = "영어 사전"
    
    var images: String {
        switch self {
        case .solveProblem:
            return "UserSpeakLinear"
        case .savedProblem:
            return "book.pages"
        case .dictionary:
            return "magnifyingglass"
        }
    }
    
    @ViewBuilder
    var showVC: some View {
        switch self {
        case .solveProblem:
            ProblemListView()
        case .savedProblem:
            SaveProblemView()
        case .dictionary:
            DiaryWriteView()
        }
    }
    
}
