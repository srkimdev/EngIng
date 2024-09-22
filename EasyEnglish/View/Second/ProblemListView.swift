//
//  ProblemListView.swift
//  EasyEnglish
//
//  Created by 김성률 on 9/12/24.
//

import SwiftUI

struct ProblemListView: View {
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                LazyVStack {
                    ForEach(Categories.allCases, id: \.self) { item in
                        chapterView(geometry, item)
                    }
                }
            }
        }
        .navigationTitle("Category")
    }
    
    func chapterView(_ geometry: GeometryProxy, _ category: Categories) -> some View {
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

                Text(category.rawValue)
                    .font(.title.bold())
                    .foregroundStyle(.white)

                Text(category.description)
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                Spacer()

                Text("Chapter 20")
                    .font(.title3)
                    .foregroundColor(.gray)

                Spacer()

                NavigationLink {
                    ProblemChapterView()
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

#Preview {
    ProblemListView()
}
