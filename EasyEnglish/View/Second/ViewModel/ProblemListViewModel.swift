//
//  ProblemListViewModel.swift
//  EasyEnglish
//
//  Created by 김성률 on 9/26/24.
//

import Foundation
import Combine
import RealmSwift

final class ProblemListViewModel: ObservableObject {
    
    @ObservedResults(CategoryTable.self) var categories
    
    var currentCategory = CategoryTable()
    
    private var cancellables = Set<AnyCancellable>()
    var input = Input()
    @Published var output = Output()

    private let repoChapter = RealmRepository<ChapterTable>()
    private let repoSentence = RealmRepository<SentenceTable>()
    
    struct Input {
        let carouselTap = CurrentValueSubject<Int, Never>(0)
        let starButtonTap = PassthroughSubject<ChapterTable, Never>()
        let progressCheck = PassthroughSubject<Void, Never>()
    }
    
    struct Output {
        var selectedCategory = CategoryTable()
        var rendering = false
    }
    
    init() {
        
        input.progressCheck
            .sink { [weak self] _ in
                guard let self else { return }
                self.checkProgress(self.currentCategory)
            }
            .store(in: &cancellables)
        
        input.carouselTap
            .sink { [weak self] value in
                guard let self else { return }
                self.output.selectedCategory = self.categories[value]
                self.currentCategory = self.categories[value]
            }
            .store(in: &cancellables)
        
        input.starButtonTap
            .sink { [weak self] value in
                guard let self else { return }
                repoChapter.updateItem(primaryKey: value.id) { value in
                    value.star.toggle()
                    self.output.rendering = value.star
                }
                repoChapter.detectRealmURL()
            }
            .store(in: &cancellables)
        
    }
    
    let a = Array([1])
    
    private func checkProgress(_ category: CategoryTable) {
        for chapter in category.chapters {
            updateProgress(for: chapter)
        }
    }
    
    private func updateProgress(for chapter: ChapterTable) {
        let totalSentences = chapter.sentences.count
        let checkedSentences = chapter.sentences.filter { $0.isCheck }.count
        
        if totalSentences > 0 {
            repoChapter.updateItem(primaryKey: chapter.id) { value in
                let progress = String(format: "%.2f", Double(checkedSentences) / Double(totalSentences) * 100)
                value.progress = Double(progress) ?? 0
            }
            output.rendering.toggle()
        }
    }
    
}
