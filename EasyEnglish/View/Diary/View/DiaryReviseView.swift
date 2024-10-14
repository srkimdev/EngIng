//
//  DiaryReviseView.swift
//  EasyEnglish
//
//  Created by 김성률 on 9/18/24.
//

import SwiftUI
import CarouselStack

struct DiaryReviseView: View {
    
    var diary: DiaryTable
    private let viewModel = DiaryReviseViewModel()
    
    var body: some View {
        
        GeometryReader { geometry in
            ScrollView {
                
                VStack(alignment: .leading) {
                    
                    Text(DateFormatManager.shared.ddmy(diary.date))
                        .padding(.bottom, 10)
                    
                    Text(diary.title)
                        .font(.title.bold())
                    
                    Image(uiImage: viewModel.output.showImage)
                        .resizable()
                        .frame(width: abs(geometry.size.width - 50), height: 240)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(.bottom)
                    
                    Text(diary.content)
                    
                }
                
            }
            .scrollIndicators(.hidden)
            .padding(25)
            
        }
        .navigationTitle("Diary")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.input.uploadImage.send(diary.date)
        }
        
    }
}

//#Preview {
//    DiaryReviseView()
//}
