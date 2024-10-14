//
//  SaveProblemView.swift
//  EasyEnglish
//
//  Created by 김성률 on 9/13/24.
//

import SwiftUI

struct SaveProblemView: View {
    
    @StateObject var viewModel = SaveProblemViewModel()
    
    var body: some View {
        
        GeometryReader { geometry in
            
            Colors.backgroundColor
            
            if viewModel.output.savedSentences.isEmpty {
                Text("저장한 문장이 없습니다.")
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .multilineTextAlignment(.center)
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
            } else {
                ScrollView(.vertical) {
                    
                    Spacer()
                        .frame(height: 20)
                    
                    LazyVStack(spacing: 20) {
                        ForEach(viewModel.output.savedSentences) { value in
                            sentenceRowView(value)
                                .frame(height: geometry.size.height / 6)
                                .padding(.horizontal)
                        }
                    }
                    
                }
                .scrollIndicators(.hidden)
            }
 
        }
        .navigationTitle("My Sentences")
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                CustomBackButton()
            }
        }
        .onAppear {
            viewModel.input.showSavedSentences.send()
        }

    }
    
    func sentenceRowView(_ sentence: SentenceTable) -> some View {
        
        RoundedRectangle(cornerRadius: 10)
            .fill(.white)
            .overlay {
                HStack {
                    VStack(alignment: .leading) {
                        Text(sentence.korean)
                        Text(sentence.english)
                    }
                    
                    Spacer()
                    
                    Button {
                        viewModel.input.trashButtonTap.send(sentence)
                    } label: {
                        Image(systemName: "trash")
                            .foregroundStyle(.black)
                    }
                }
                .padding()
            }
        
    }
    
    
}

#Preview {
    SaveProblemView()
}
