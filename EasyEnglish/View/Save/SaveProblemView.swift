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
        .navigationTitle("My Sentences")
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
