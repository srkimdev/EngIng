//
//  ProblemSentenceView.swift
//  EasyEnglish
//
//  Created by 김성률 on 9/22/24.
//

import SwiftUI
import ShuffleDeck
import AlertToast

struct ProblemSentenceView: View {
    
    private let repository = RealmRepository<ChapterTable>()
    
    @State private var currentPage: Int = 0
    @State private var showToast = false
    @StateObject var viewModel: ProblemSentenceViewModel
    
    let colors: [Color] = [.white, .white, .white, .white, .white, .white, .white, .white, .white, .white]
    
    var body: some View {
        
        GeometryReader { geometry in
            
            VStack {
                ShuffleDeck(
                    colors,
                    initialIndex: 0
                ) { color in
                    color
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .border(.black, width: 1)
                        .frame(width: abs(geometry.size.width - 60), height: abs(geometry.size.height / 1.4))
                        .overlay {
                            
                            VStack {
                                
                                Spacer()
                                
                                Text(viewModel.chapter.sentences[currentPage].korean)
                                
                                Spacer()
                                
                                Rectangle()
                                    .frame(height: 1)
                                
                                Spacer()
                                
                                if viewModel.output.answerButtonStatus {
                                    Text(viewModel.chapter.sentences[currentPage].english)
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
                    viewModel.output.answerButtonStatus = false
                })
                .padding(.top, 20)
                
                HStack {
                    
                    Spacer()
                    
                    Button(action: {
                        repository.updateItem(primaryKey: viewModel.chapter.id) { value in
                            value.sentences[currentPage].isLike = true
                            showToast.toggle()
                        }
                    }) {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.orange.opacity(0.2))
                            .overlay {
                                Image(systemName: "folder")
                                    .foregroundStyle(.black)
                            }
                            
                    }
                    .frame(width: geometry.size.width / 8, height: geometry.size.width / 8)
                    
                    Spacer()
                    
                    Button(action: {
                        viewModel.input.answerButtonTap.send()
                        repository.updateItem(primaryKey: viewModel.chapter.id) { value in
                            value.sentences[currentPage].isCheck = true
                            value.sentences[currentPage].whenSolved = DateFormatManager.shared.getyymmdd(Date())
                        }
                    }) {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.orange.opacity(0.2))
                            .overlay {
                                Text("정답보기")
                                    .foregroundStyle(.black)
                            }
                    }
                    .frame(width: geometry.size.width / 4, height: geometry.size.width / 8)
                    
                    Spacer()
                    
                    Button(action: {
                        if viewModel.output.answerButtonStatus {
                            viewModel.input.soundButtonTap.send(viewModel.chapter.sentences[currentPage].english)
                        }
                    }) {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.orange.opacity(0.2))
                            .overlay {
                                Image(systemName: "speaker.wave.2")
                                    .foregroundStyle(.black)
                            }
                    }
                    .frame(width: geometry.size.width / 8, height: geometry.size.width / 8)
                    
                    
                    Spacer()
                    
                }
                .padding()
                .frame(maxWidth: .infinity)
    
            }
            
        }
        .navigationTitle(viewModel.chapter.chapterName)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                CustomBackButton()
            }
        }
        .scrollIndicators(.hidden)
        .toast(isPresenting: $showToast, duration: 1.5, tapToDismiss: true) {
            AlertToast(displayMode: .banner(.slide), type: .regular, title: "저장되었습니다.")
        }
        
    }
    
}

//#Preview {
//    ProblemSentenceView()
//}
