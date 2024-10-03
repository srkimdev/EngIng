//
//  TranslateView.swift
//  EasyEnglish
//
//  Created by 김성률 on 9/19/24.
//

import SwiftUI

struct TranslateView: View {
    
    @State private var previousText: String = ""
    @StateObject private var viewModel = TranslateViewModel()
    
    var body: some View {
        
        ZStack {
            
            VStack(spacing: 0) {
                
                Rectangle()
                    .fill(.orange.opacity(0.05))
                    .overlay {
                        CustomTextEditor(text: $previousText, placeholder: "Enter some text")
                            .padding([.top, .horizontal], 25)
                            .padding(.bottom, 80)
                    }
                
                Rectangle()
                    .fill(.gray.opacity(0.5))
                    .frame(height: 1)
                
                Rectangle()
                    .fill(.white)
                    .overlay(alignment: .topLeading) {
                        Text(viewModel.output.translatedText)
                            .padding(.top, 80)
                            .padding(.horizontal, 35)
                    }
            }
            
            middleItemView()
            
        }
        .navigationTitle("Translate")
            
    }
    
    func middleItemView() -> some View {
        
        VStack {
            HStack {
                Text("한국어")
                        .foregroundStyle(.black)
                
                Spacer()
                
                Button(action: {
                    viewModel.input.inputText.send(previousText)
                }, label: {
                    Text("번역하기")
                })
            
            }
            .padding(24)
            
            HStack {
                
                Text("English")
                    .foregroundStyle(.black)
                
                Spacer()

                Button(action: {
                    if !viewModel.output.translatedText.isEmpty {
                        viewModel.input.ttsButtonTap.send(viewModel.output.translatedText)
                    }
                }, label: {
                    Image(systemName: "speaker.wave.2")
                        .foregroundStyle(.black)
                })
            }
            .padding(24)

        }
        
    }
    
}

#Preview {
    TranslateView()
}
