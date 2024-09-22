//
//  ProblemSentenceView.swift
//  EasyEnglish
//
//  Created by 김성률 on 9/22/24.
//

import SwiftUI
import ShuffleDeck

struct ProblemSentenceView: View {
    
    let colors: [Color] = [.blue, .brown, .black, .cyan, .green, .indigo, .pink, .purple, .red, .orange, .yellow]
    
    var body: some View {
        
        GeometryReader { geometry in
            
            ShuffleDeck(
                colors,
                initialIndex: 0
            ) { color in
                color
                    .cornerRadius(16)
                    .frame(width: abs(geometry.size.width - 60), height: abs(geometry.size.height / 1.4))
            }
            .padding(.top, 30)
            
        }
        
    }
}

#Preview {
    ProblemSentenceView()
}
