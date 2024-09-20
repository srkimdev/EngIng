//
//  ProblemListView.swift
//  EasyEnglish
//
//  Created by 김성률 on 9/12/24.
//

import SwiftUI

struct ProblemListView: View {
    
    private let columns = [
        GridItem(.fixed((Constants.screenWidth - 50) / 2), spacing: 15),
        GridItem(.fixed((Constants.screenWidth - 50) / 2), spacing: 15)
    ]
    
    var body: some View {
        
        ScrollView {
            
            Text("카테고리")
                .font(.system(size: 20).bold())
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            
            LazyVGrid(columns: columns, spacing: 15){
                
                ForEach(0..<10) { item in
                    categoryRowView()
                }
                
            }
            
        }
        .navigationTitle("둘러보기")
        .toolbar(.hidden, for: .tabBar)
        
    }
    
    private func categoryRowView() -> some View {
        
        ZStack {
            
            NavigationLink {
                ProblemChapterView()
            } label: {
                RoundedRectangle(cornerRadius: 8)
                    .fill(.gray.opacity(0.3))
                    .frame(height: 90)
            }
                
            HStack {
                Text("영화")
                
                Spacer()
                
                Image(systemName: "star")
            }
            .padding()
        
        }
        
    }
    
}

#Preview {
    ProblemListView()
}
