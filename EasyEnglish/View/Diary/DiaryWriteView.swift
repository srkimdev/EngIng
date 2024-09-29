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
    
    @State private var savedImage: UIImage?
    @State private var photosPickerItem: PhotosPickerItem?
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        
        GeometryReader { geometry in
            VStack {
                
                RoundedRectangle(cornerRadius: 10)
                    .fill(.white)
                    .frame(width: abs(geometry.size.width - 50), height: abs(geometry.size.width - 50) * 0.618)
                    .overlay {
                        if let savedImage = savedImage {
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
                
                ZStack(alignment: .topLeading) {
                    
                    if viewModel.titleText.isEmpty {
                        Text("제목을 입력해주세요.")
                            .padding(.vertical, 8)
                            .foregroundStyle(.gray)
                    }
                    
                    TextEditor(text: $viewModel.titleText)
                        .frame(height: 50)
                        .opacity(viewModel.titleText.isEmpty ? 0.5 : 1)
                }
                
                Text("Story")
                    .font(.system(size: 24).bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                ZStack(alignment: .topLeading) {
                    if viewModel.storyText.isEmpty {
                        Text("내용을 입력해주세요.")
                            .padding(.vertical, 8)
                            .foregroundStyle(.gray)
                    }
                    
                    TextEditor(text: $viewModel.storyText)
                        .opacity(viewModel.storyText.isEmpty ? 0.5 : 1)
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
                    
                    PhotosPicker(selection: $photosPickerItem, matching: .images) {
                        Circle()
                            .fill(.orange.opacity(0.2))
                            .frame(width: 50, height: 50)
                            .overlay {
                                Image(systemName: "camera")
    //                                .resizable()
    //                                .frame(width: 20, height: 20)
                                    .foregroundStyle(.black)
                            }
                    }
                    
                }
                
            }
            .padding(25)
            .navigationTitle("Write")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        viewModel.input.saveButtonTapped.send()
                        dismiss()
                    } label: {
                        Text("저장")
                            .foregroundStyle(.black)
                    }

                }
            }
            .onChange(of: photosPickerItem) { _ in
                Task {
                    if let photosPickerItem, let data = try? await photosPickerItem.loadTransferable(type: Data.self) {
                        if let image = UIImage(data: data) {
                            savedImage = image
                            print(savedImage)
                        }
                    }
                    
                    photosPickerItem = nil
                }
            }
        }
        
    }
    
}

//#Preview {
//    DiaryWriteView()
//}
