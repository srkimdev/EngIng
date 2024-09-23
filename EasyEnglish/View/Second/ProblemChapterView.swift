//
//  ProblemChapterView.swift
//  EasyEnglish
//
//  Created by 김성률 on 9/14/24.
//

import SwiftUI
import RealmSwift

struct ProblemChapterView: View {
    
    @State private var progress = 0.5
    var category: CategoryTable

    var body: some View {
        
        GeometryReader { geometry in
            
            let size = abs((geometry.size.width - 50) / 2)
            
            let columns = [
                GridItem(.fixed(size), spacing: 15),
                GridItem(.fixed(size), spacing: 15)
            ]
            
            Colors.backgroundColor
            
            ScrollView {
                
                Text(category.categoryName)
                    .font(.title.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                LazyVGrid(columns: columns, spacing: 15){
                    ForEach(category.chapters, id: \.id) { item in
                        categoryRowView(item, size)
                    }
                }
                
            }
            .navigationTitle("둘러보기")
            .toolbar(.hidden, for: .tabBar)
            
        }

    }
    
    private func categoryRowView(_ chapter: ChapterTable ,_ height: CGFloat) -> some View {
        
        ZStack {
            
            NavigationLink {
                ProblemSentenceView()
            } label: {
                RoundedRectangle(cornerRadius: 8)
                    .fill(.white)
            }
            .frame(width: height, height: height)
                
            VStack(alignment: .leading) {
                Spacer()
                Image(systemName: "star")
                Spacer()
                Text(chapter.chapterName)
                    .font(.title2)
                Spacer()
                Text("Your completed 50%")
                    .font(.system(size: 13))
                ProgressView(value: progress)
            }
            .padding()
        
        }
        
    }
}

//#Preview {
//    ProblemChapterView(category: )
//}
