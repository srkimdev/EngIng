//
//  ProblemSentenceView.swift
//  EasyEnglish
//
//  Created by 김성률 on 9/22/24.
//

import SwiftUI
import ShuffleDeck

struct ProblemSentenceView: View {
    
//    var chapter: ChapterTable
    
//    let colors: [Color] = [.blue, .brown, .black, .cyan, .green, .indigo, .pink, .purple, .red, .orange, .yellow]
    let colors: [Color] = [.white, .white, .white, .white, .white, .white, .white, .white, .white, .white]
    
    var body: some View {
        
        GeometryReader { geometry in
            
            ShuffleDeck(
                colors,
                initialIndex: 0
            ) { color in
                color
                    .border(.black, width: 1)
                    .frame(width: abs(geometry.size.width - 60), height: abs(geometry.size.height / 1.4))
//                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .overlay {
                        
                        VStack {
                            
                            Spacer()
                            
                            Text("한국어")
                            
                            Spacer()
                            
                            Rectangle()
                                .frame(height: 1)
                            
                            Spacer()
                            
                            Text("What are you doing?")
                            
                            Spacer()
                            
                        }
                        .padding()
                        
                    }
            }
            .onShuffleDeck({ index in
                print(index)
            })
            .padding(.top, 30)
            
        }
        
    }
}

//#Preview {
//    ProblemSentenceView()
//}
