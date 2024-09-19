//
//  TranslateView.swift
//  EasyEnglish
//
//  Created by 김성률 on 9/19/24.
//

import SwiftUI

struct TranslateView: View {
    
    @State private var previousText: String = ""
    @State private var afterText: String = ""
    
    @StateObject private var viewModel = TranslateViewModel()
    
    var body: some View {

        ZStack {
            VStack(spacing: 0) {
                Rectangle()
                    .fill(.blue.opacity(0.3))
                    .overlay {
                        CustomTextEditor(text: $previousText, placeholder: "Enter some text")
                            .padding([.top, .horizontal], 25)
                            .padding(.bottom, 70)
                    }
                
                Rectangle()
                    .fill(.white)
                    .overlay {
                        TextEditor(text: $viewModel.output.translatedText)
                            .padding([.bottom, .horizontal], 25)
                            .padding(.top, 70)
                    }
            }
            
            VStack {
                Text("한국어")
                    .foregroundStyle(.white)
                Button(action: {
                    viewModel.input.inputText.send(previousText) //
                }, label: {
                    Circle()
                        .fill(.white)
                        .frame(width: 40, height: 40)
                        .overlay {
                            Image(systemName: "star")
                        }
                })
                .padding()
                Text("English")
                    .foregroundStyle(.blue)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(20)
            
        }
        .navigationTitle("Translate")
            
//            TextEditor(text: $previousText)
//                
//            
//            Rectangle()
//                .frame(height: 1)
//            TextEditor(text: $viewModel.output.translatedText)
//            
//            Button {
//
//                viewModel.input.inputText.send(previousText)
//            } label: {
//                RoundedRectangle(cornerRadius: 10)
//                    .frame(height: 70)
//                    .overlay {
//                        Text("번역하기")
//                    }
//            }

            
        }

}

#Preview {
    TranslateView()
}
