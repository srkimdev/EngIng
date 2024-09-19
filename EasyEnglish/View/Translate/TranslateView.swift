//
//  TranslateView.swift
//  EasyEnglish
//
//  Created by 김성률 on 9/19/24.
//

import SwiftUI

struct TranslateView: View {
    
    @State private var previousText: String = "ddd"
    @State private var afterText: String = "aaa"
    
    var body: some View {
        
        VStack {
            
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(.gray)
                    .frame(height: 55)
                
                
                HStack {
                    
                    Spacer()
                    
                    Text("한국어")
                    
                    Spacer()
                    
                    Circle()
                        .fill(.red)
                        .frame(width: 75, height: 80)
                        .overlay {
    //                        Image(systemName: <#T##String#>)
                    }
                    
                    Spacer()
                    
                    Text("English")
                    
                    Spacer()
                    
                }
            }
            
            TextEditor(text: $previousText)
            TextEditor(text: $afterText)
            
            Button {
                
            } label: {
                RoundedRectangle(cornerRadius: 10)
                    .frame(height: 70)
                    .overlay {
                        Text("번역하기")
                    }
            }

            
        }
        .padding(25)
        
        
    }
}

#Preview {
    TranslateView()
}
