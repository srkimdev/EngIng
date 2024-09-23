//
//  ProblemListView.swift
//  EasyEnglish
//
//  Created by 김성률 on 9/12/24.
//

import SwiftUI
import RealmSwift

struct ProblemListView: View {
    
    @ObservedResults(CategoryTable.self) var categories
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                LazyVStack {
                    ForEach(categories, id: \.id) { item in
                        chapterView(geometry, item)
                    }
                }
            }
        }
        .navigationTitle("Category")
    }
    
    func chapterView(_ geometry: GeometryProxy, _ category: CategoryTable) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(.cyan)
                .frame(width: geometry.size.width - 50, height: geometry.size.width - 50)
                .padding(.bottom)

            VStack(alignment: .center, spacing: 10) {
                
                Spacer()
                
                Image(systemName: "star")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
                
                Spacer()

                Text(category.categoryName)
                    .font(.title.bold())
                    .foregroundStyle(.white)

                Text(category.categoryDescription)
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                Spacer()

                Text("chapter20")
                    .font(.title3)
                    .foregroundColor(.gray)

                Spacer()

                NavigationLink {
                    ProblemChapterView(category: category)
                } label: {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.white)
                        .frame(width: geometry.size.width - 90, height: geometry.size.height / 15)
                        .overlay(
                            Text("시작하기")
                                .foregroundColor(.black)
                                .fontWeight(.bold)
                        )
                }
                .padding(.bottom, 20)
            }
            .padding()
        }
    }
    
}

//#Preview {
//    ProblemListView()
//}
