//
//  DiaryWriteView.swift
//  EasyEnglish
//
//  Created by 김성률 on 9/17/24.
//

import SwiftUI

struct DiaryWriteView: View {
    
    @State var titleText: String = ""
    @State var storyText: String = ""
    
    var body: some View {
        
        VStack {
            
            Text("Title")
                .font(.system(size: 24).bold())
                .frame(maxWidth: .infinity, alignment: .leading)
            
            TextEditor(text: $titleText)
//                .frame(height: 50)
                .overlay(alignment: .topLeading) {
                    Text("제목을 입력해주세요.")
                        .padding(.vertical, 8)
                        .foregroundStyle(titleText.isEmpty ? .gray : .clear)
                }
            
            Text("Story")
                .font(.system(size: 24).bold())
                .frame(maxWidth: .infinity, alignment: .leading)
            
            TextEditor(text: $storyText)
//                .frame(height: 250)
                .overlay(alignment: .topLeading) {
                    Text("내용을 입력해주세요.")
                        .padding(.vertical, 8)
                        .foregroundStyle(storyText.isEmpty ? .gray : .clear)
                }
            
            Spacer()
            
            HStack {
                
                NavigationLink {
                    TranslateView()
                } label: {
                    
                    Circle()
                        .fill(.cyan)
                        .frame(width: 50, height: 50)
                        .overlay {
                            Image(systemName: "translate")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundStyle(.black)
                        }
                    
                }
                
                Spacer()
                
                Button(action: {
                    print("camera")
                }, label: {
                    
                    Circle()
                        .fill(.cyan)
                        .frame(width: 50, height: 50)
                        .overlay {
                            Image(systemName: "camera")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundStyle(.black)
                        }
        
                })
                
            }
            
        }
        .padding(25)
        .navigationTitle("Write")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    print("Save")
                } label: {
                    Text("저장")
                        .foregroundStyle(.black)
                }

            }
        }
        
    }
    
}

#Preview {
    DiaryWriteView()
}
