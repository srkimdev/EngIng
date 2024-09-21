//
//  ProblemListView.swift
//  EasyEnglish
//
//  Created by 김성률 on 9/12/24.
//

import SwiftUI

struct ProblemListView: View {
    
    @State private var progress = 0.5
    
    var body: some View {
        
        GeometryReader { geometry in
            
            let size = (geometry.size.width - 50) / 2
            
            let columns = [
                GridItem(.fixed(size), spacing: 15),
                GridItem(.fixed(size), spacing: 15)
            ]
            
            Colors.backgroundColor
            
            ScrollView {
                
                Text("Category")
                    .font(.title.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                LazyVGrid(columns: columns, spacing: 15){
                    ForEach(Categories.allCases, id: \.self) { item in
                        categoryRowView(item, size)
                    }
                }
                
            }
            .navigationTitle("둘러보기")
            .toolbar(.hidden, for: .tabBar)
            
        }
        
        
        
    }
    
    private func categoryRowView(_ category: Categories, _ height: CGFloat) -> some View {
        
        ZStack {
            
            NavigationLink {
                ProblemChapterView(category: category)
            } label: {
                RoundedRectangle(cornerRadius: 8)
                    .fill(.white)
                    .frame(height: height)
            }
                
            VStack(alignment: .leading) {
                Spacer()
                Image(systemName: "star")
                Spacer()
                Text(category.rawValue)
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

#Preview {
    ProblemListView()
}
