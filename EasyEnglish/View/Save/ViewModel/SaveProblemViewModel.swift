//
//  SaveProblemViewModel.swift
//  EasyEnglish
//
//  Created by 김성률 on 9/27/24.
//

import Foundation
import RealmSwift
import Combine

final class SaveProblemViewModel: ObservableObject {
    
    private let realmrepository = RealmRepository<SentenceTable>()
    @ObservedResults(SentenceTable.self) var sentences
    
    let input = Input()
    @Published var output = Output()
    
    var cancellables = Set<AnyCancellable>()
    
    struct Input {
        let showSavedSentences = PassthroughSubject<Void, Never>()
        let trashButtonTap = PassthroughSubject<SentenceTable, Never>()
    }
    
    struct Output {
        var savedSentences: [SentenceTable] = []
    }
    
    init() {
        input.showSavedSentences
            .sink { _ in
                self.output.savedSentences = self.sentences.filter { $0.isLike == true }
                print(self.output.savedSentences, "list")
            }
            .store(in: &cancellables)
        
        input.trashButtonTap
            .sink { value in
                self.realmrepository.updateItem(primaryKey: value.id) { value in
                    value.isLike = false
                }
                self.output.savedSentences = self.sentences.filter { $0.isLike == true }
            }
            .store(in: &cancellables)
    }
    
}
