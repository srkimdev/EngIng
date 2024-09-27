//
//  ProblemSentenceView.swift
//  EasyEnglish
//
//  Created by 김성률 on 9/22/24.
//

import SwiftUI
import ShuffleDeck

struct ProblemSentenceView: View {
    
    private let repository = RealmRepository<ChapterTable>()
    
    var chapter: ChapterTable
    
    @State var currentPage: Int = 0
    @State var answerButtonClick: Bool = false
    
    let colors: [Color] = [.white, .white, .white, .white, .white, .white, .white, .white, .white, .white]
    
    var body: some View {
        
        GeometryReader { geometry in
            
            VStack {
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
                                
                                Text(chapter.sentences[currentPage].korean)
                                
                                Spacer()
                                
                                Rectangle()
                                    .frame(height: 1)
                                
                                Spacer()
                                
                                if answerButtonClick {
                                    Text(chapter.sentences[currentPage].english)
                                } else {
                                    Text("")
                                }
                                
                                Spacer()
                                
                            }
                            .padding()
                            
                        }
                }
                .onShuffleDeck({ value in
                    currentPage = value.index
                    answerButtonClick = false
                })
                .padding(.top, 30)
                
                Button(action: {
                    answerButtonClick.toggle()
                
                    repository.updateItem(primaryKey: chapter.id) { value in
                        value.sentences[currentPage].isCheck = true
                    }
                   
                }, label: {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 50, height: 50)
                })
            }
            
        }
        
    }
    
}

//#Preview {
//    ProblemSentenceView()
//}
