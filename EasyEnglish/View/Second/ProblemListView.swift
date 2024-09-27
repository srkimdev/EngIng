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
    
    let colors: [Color] = [.blue.opacity(0.2), .brown, .black, .cyan, .green, .indigo, .pink, .purple, .red, .orange, .yellow]
    
    @StateObject private var viewModel = ProblemListViewModel()
    
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
                            .overlay {
                                Text("124")
                            }
                    }
                    .carouselStyle(.infiniteScroll)
                    .carouselScale(0.8)
                    .carouselAnimation(.easeInOut)
                    .onCarousel { value in
                        viewModel.input.carouselTap.send(value.index)
                    }

                ScrollView {
                        
                    VStack {
                        Text("Example")
                        
                        ForEach(viewModel.output.selectedCategory.chapters, id: \.self) { item in
                            categoryRowView(item)
                        }
                        .transition(.asymmetric(insertion: .move(edge: .bottom).combined(with: .opacity), removal: .move(edge: .top).combined(with: .opacity)))
                        .animation(.easeInOut, value: viewModel.output.selectedCategory.chapters)
                        
                    }
                    .padding()
                    
                }
                
            }

        }
        .onAppear {
            viewModel.input.progressCheck.send()
        }
        
    }
    
    private func categoryRowView(_ chapter: ChapterTable) -> some View {

        ZStack {
            
            Color.gray.opacity(0.1)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            NavigationLink {
                ProblemSentenceView(chapter: chapter)
            } label: {
                RoundedRectangle(cornerRadius: 8)
                    .fill(.white)
            }
                
            VStack(alignment: .leading) {
                Spacer()
                HStack {
                    Text(chapter.chapterName)
                        .font(.title2)
                    Spacer()
                    Button {
                        viewModel.input.starButtonTap.send(chapter)
                    } label: {
                        Image(systemName: chapter.star ? "star.fill" : "star")
                            .foregroundStyle(.blue.opacity(0.3))
                    }
                }
                Spacer()
                Text("Your completed \(Int(chapter.progress))%")
                    .font(.system(size: 13))
                ProgressView(value: chapter.progress / 100)
                    
            }
            .padding()
        
        }
        
    }
    
}

#Preview {
    ProblemListView()
}
