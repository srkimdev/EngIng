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
    
    let input = Input()
    @Published var output = Output()
    
    private var cancellables = Set<AnyCancellable>()
    
    struct Input {
        let showSavedSentences = PassthroughSubject<Void, Never>()
        let trashButtonTap = PassthroughSubject<SentenceTable, Never>()
    }
    
    struct Output {
        var savedSentences: [SentenceTable] = []
    }
    
    init() {
        input.showSavedSentences
            .sink { [weak self] _ in
                guard let self else { return }
                output.savedSentences = realmrepository.readAllItem().filter { $0.isLike == true }
            }
            .store(in: &cancellables)
        
        input.trashButtonTap
            .sink { [weak self] value in
                guard let self else { return }
                realmrepository.updateItem(primaryKey: value.id) { value in
                    value.isLike = false
                }
                output.savedSentences = realmrepository.readAllItem().filter { $0.isLike == true }
            }
            .store(in: &cancellables)
    }
    
}
