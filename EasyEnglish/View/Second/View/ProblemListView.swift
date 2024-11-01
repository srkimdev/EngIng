//
//  ProblemListView.swift
//  EasyEnglish
//
//  Created by 김성률 on 9/12/24.
//

import SwiftUI
import CarouselStack

struct ProblemListView: View {
    
    @StateObject private var viewModel = ProblemListViewModel()
    
    var body: some View {
        
        GeometryReader { geometry in
        
            VStack {
                CarouselStack(Categories.allCases, initialIndex: 0) { category in
                    bannerView(category, geometry)
                        .frame(width: geometry.size.width / 1.2, height: geometry.size.width / 1.96)
                }
                .carouselStyle(.infiniteScroll)
                .carouselScale(0.8)
                .carouselAnimation(.easeInOut)
                .onCarousel { value in
                    viewModel.input.carouselTap.send(value.index)
                }

                ScrollView {
                    VStack {
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
    
    private func bannerView(_ category: Categories, _ geometry: GeometryProxy) -> some View {
        
        RoundedRectangle(cornerRadius: 16)
            .fill(category.colors)
            .overlay {
                HStack {
                    VStack {
                        Spacer()
                        Image(category.images)
                            .resizable()
                            .scaledToFit()
                            .frame(width: geometry.size.width / 3.2)
                    }
                    Spacer()
                    Text(category.rawValue)
                        .font(.system(size: 24).bold())
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                .padding(.horizontal)
            }
        
    }
    
    private func categoryRowView(_ chapter: ChapterTable) -> some View {

        ZStack {
            
            NavigationLink {
                ProblemSentenceView(viewModel: ProblemSentenceViewModel(chapter: chapter))
            } label: {
                RoundedRectangle(cornerRadius: 8)
                    .fill(.gray.opacity(0.1))
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
                            .foregroundStyle(.blue)
                    }
                }
                Spacer()
                Text("Your completed \(Int(chapter.progress))%")
                    .font(.system(size: 13))
                ProgressView(value: chapter.progress / 100)
                    
            }
            .padding()
        
        }
        .padding(.bottom, 10)
        
    }
    
}

#Preview {
    ProblemListView()
}
