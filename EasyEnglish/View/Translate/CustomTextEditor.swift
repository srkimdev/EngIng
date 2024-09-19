//
//  CustomTextEditor.swift
//  EasyEnglish
//
//  Created by 김성률 on 9/19/24.
//

import SwiftUI

struct CustomTextEditor: View {
    
    @Binding var text: String
    var placeholder: String
    var placeholderColor: Color = .gray
    
    var body: some View {
        
        ZStack {
            
            Color.blue.opacity(0.3)
            
            TextEditor(text: $text)
                .padding(4)
            
            if text.isEmpty {
                Text(placeholder)
                    .foregroundStyle(placeholderColor)
                    .padding(.horizontal, 5)
                    .padding(.vertical, 8)
            }
        }
        
    }
    
}
