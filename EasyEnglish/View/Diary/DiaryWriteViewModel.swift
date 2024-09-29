//
//  DiaryWriteViewModel.swift
//  EasyEnglish
//
//  Created by 김성률 on 9/25/24.
//

import Foundation
import Combine

final class DiaryWriteViewModel: ObservableObject {
    
    var cancellables = Set<AnyCancellable>()
    var input = Input()
    @Published var output = Output()
    
    @Published var titleText = ""
    @Published var storyText = ""
    
    let repository = RealmRepository<DiaryTable>()
    
    struct Input {
        let saveButtonTapped = PassthroughSubject<Void, Never>()
    }
    
    struct Output {
        var diary = DiaryTable()
        var isAllowed = false
    }
    
    init() {
        
        input.saveButtonTapped
            .sink { [weak self] _ in
                guard let self else { return }
                saveDiary()
            }
            .store(in: &cancellables)
        
    }
    
    private func saveDiary() {
        
        if titleText.isEmpty || storyText.isEmpty {
            output.isAllowed = false
        } else {
            repository.createItem(DiaryTable(title: titleText, content: storyText))
            output.isAllowed = true
        }
        
    }
    
}
