//
//  DiaryWriteView.swift
//  EasyEnglish
//
//  Created by 김성률 on 9/17/24.
//

import SwiftUI

struct DiaryWriteView: View {
    
    @State var titleText: String = "제목을 입력해주세요."
    @State var storyText: String = "내용을 입력해주세요."
    
    var body: some View {
        
        VStack {
            
            Text("Title")
                .font(.system(size: 24).bold())
                .frame(maxWidth: .infinity, alignment: .leading)
            
            TextEditor(text: $titleText)
                .frame(height: 100)
            
            Text("Story")
                .font(.system(size: 24).bold())
                .frame(maxWidth: .infinity, alignment: .leading)
            
            TextEditor(text: $storyText)
            
            Spacer()
            
            HStack {
                
                Image(systemName: "star")
                Image(systemName: "camera")
                
                Spacer()
                
                Button(action: {
                    print("back")
                }, label: {
                    RoundedRectangle(cornerRadius: 25)
                        .frame(width: Constants.screenWidth / 3, height: 50)
                        .overlay {
                            Text("Submit")
                                .font(.title2)
                                .foregroundStyle(.white)
                        }
                })
                
            }
            .navigationTitle("Write")
            .navigationBarTitleDisplayMode(.inline)
            
                
        }
        .padding(25)
        
    }
}

#Preview {
    DiaryWriteView()
}
