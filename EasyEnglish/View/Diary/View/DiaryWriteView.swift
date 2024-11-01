//
//  DiaryWriteView.swift
//  EasyEnglish
//
//  Created by 김성률 on 9/17/24.
//

import SwiftUI
import PhotosUI

struct DiaryWriteView: View {
    
    @StateObject private var viewModel = DiaryWriteViewModel()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        
        GeometryReader { geometry in
            VStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.white)
                    .frame(width: abs(geometry.size.width - 50), height: abs(geometry.size.width - 50) * 0.618)
                    .overlay {
                        if let savedImage = viewModel.savedImage {
                            Image(uiImage: savedImage)
                                .resizable()
                                .scaledToFill()
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                
                        } else {
                            Image(systemName: "camera")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                        }
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black, lineWidth: 1)
                    )
                    .padding(.bottom)
                
                Text("Title")
                    .font(.system(size: 24).bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                TextField("Write a title in English", text: $viewModel.titleText)
                        .frame(height: 50)
                
                Text("Story")
                    .font(.system(size: 24).bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                ZStack(alignment: .topLeading) {
                    if viewModel.storyText.isEmpty {
                        Text("Write a content in English")
                            .padding(.vertical, 8)
                            .foregroundStyle(.gray)
                    }
                    
                    TextEditor(text: $viewModel.storyText)
                        .opacity(viewModel.storyText.isEmpty ? 0.5 : 1)
                        .padding(.horizontal, -4)
                }
                
                Spacer()

                HStack {
                    
                    NavigationLink {
                        TranslateView()
                    } label: {
                        
                        Circle()
                            .fill(.orange.opacity(0.2))
                            .frame(width: 50, height: 50)
                            .overlay {
                                Image(systemName: "translate")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .foregroundStyle(.black)
                            }
                        
                    }
                    
                    Spacer()
                    
                    PhotosPicker(selection: $viewModel.photosPickerItem, matching: .images) {
                        Circle()
                            .fill(.orange.opacity(0.2))
                            .frame(width: 50, height: 50)
                            .overlay {
                                Image(systemName: "camera")
                                    .foregroundStyle(.black)
                            }
                    }
                    
                }
                
            }
            .padding(25)
            .navigationTitle("Write")
            .navigationBarTitleDisplayMode(.inline)
            .onTapGesture {
                hideKeyboard()
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        
                        viewModel.input.saveButtonTapped.send()
                        
                        if viewModel.output.isAllowed {
                            dismiss()
                            viewModel.output.isAllowed = false
                        }
                        
                    } label: {
                        Text("저장")
                            .foregroundStyle(.black)
                    }

                }
            }
            .onChange(of: viewModel.photosPickerItem) { _ in
                Task {
                    await viewModel.handlePickerItemChange()
                }
            }
        }
        
    }
    
}

//#Preview {
//    DiaryWriteView()
//}
