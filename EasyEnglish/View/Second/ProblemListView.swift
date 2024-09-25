//
//  ProblemListView.swift
//  EasyEnglish
//
//  Created by 김성률 on 9/12/24.
//

import SwiftUI
import RealmSwift
import CarouselStack

struct ProblemListView: View {
    
    @ObservedResults(CategoryTable.self) var categories
    let colors: [Color] = [.blue, .brown, .black, .cyan, .green, .indigo, .pink, .purple, .red, .orange, .yellow]
    
    @State private var progress = 0.5
    
    var body: some View {
        
        GeometryReader { geometry in
        
            VStack {
                CarouselStack(
                        colors,
                        initialIndex: 0
                    ) { color in
                        color
                            .frame(width: geometry.size.width / 1.2, height: geometry.size.width / 1.96)
                            .cornerRadius(16)
                    }
                    .carouselStyle(.infiniteScroll)
                    .carouselScale(0.8)
                    .carouselAnimation(.easeInOut)

                ScrollView {
                        
                    VStack {
                        Text("Example")
                        
                        ForEach(0..<4) { item in
                            categoryRowView()
                        }
                        
                    }
                    .padding()
                    
                }
                
            }

        }
        
    }
    
    private func categoryRowView() -> some View {

        ZStack {
            
            Color.gray.opacity(0.1)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
//            NavigationLink {
////                ProblemSentenceView(chapter: chapter)
//            } label: {
//                RoundedRectangle(cornerRadius: 8)
//                    .fill(.white)
//            }
                
            VStack(alignment: .leading) {
                Spacer()
                Image(systemName: "star")
                Spacer()
                Text("chapter1")
                    .font(.title2)
                Spacer()
                Text("Your completed %")
                    .font(.system(size: 13))
                ProgressView(value: progress)
            }
            .padding()
        
        }
        
    }
    
//    func chapterView(_ geometry: GeometryProxy, _ category: CategoryTable) -> some View {
//        ZStack {
//            RoundedRectangle(cornerRadius: 20)
//                .fill(.cyan)
//                .frame(width: geometry.size.width - 50, height: geometry.size.width - 50)
//                .padding(.bottom)
//
//            VStack(alignment: .center, spacing: 10) {
//                
//                Spacer()
//                
//                Image(systemName: "star")
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width: 50, height: 50)
//                
//                Spacer()
//
//                Text(category.categoryName)
//                    .font(.title.bold())
//                    .foregroundStyle(.white)
//
//                Text(category.categoryDescription)
//                    .font(.body)
//                    .multilineTextAlignment(.center)
//                    .padding(.horizontal)
//
//                Text("chapter20")
//                    .font(.title3)
//                    .foregroundColor(.gray)
//
//                Spacer()
//
//                NavigationLink {
//                    ProblemChapterView(category: category)
//                } label: {
//                    RoundedRectangle(cornerRadius: 10)
//                        .fill(.white)
//                        .frame(width: geometry.size.width - 90, height: geometry.size.height / 15)
//                        .overlay(
//                            Text("시작하기")
//                                .foregroundColor(.black)
//                                .fontWeight(.bold)
//                        )
//                }
//                .padding(.bottom, 20)
//            }
//            .padding()
//        }
//    }
    
}

#Preview {
    ProblemListView()
}
