//
//  CustomBackButton.swift
//  EasyEnglish
//
//  Created by 김성률 on 9/17/24.
//

import SwiftUI

struct CustomBackButton: View {
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        Button {
            print("dismiss")
            dismiss()
        } label: {
            Image(systemName: "chevron.left")
                .foregroundStyle(.black)
        }
    }
}

