//
//  CustomBackButton.swift
//  EasyEnglish
//
//  Created by 김성률 on 9/17/24.
//

import SwiftUI

struct CustomBackButton {
    
    @Environment(\.dismiss) private var dismiss
    
    func backButton() -> some View {
        Button {
            print("dismiss")
            dismiss()
        } label: {
            Image(systemName: "chevron.left")
        }
    }
    
}

