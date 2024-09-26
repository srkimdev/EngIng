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
    
    let repository = RealmRepository<DiaryTable>()
    
    struct Input {
        var titleText = ""
        var storyText = ""
        
        let saveButtonTapped = PassthroughSubject<Void, Never>()
    }
    
    struct Output {
        var diary = DiaryTable()
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
        
        if input.titleText.isEmpty || input.storyText.isEmpty {
            
        } else {
            repository.createItem(DiaryTable(title: input.titleText, content: input.storyText))
    
        }
        
    }
    
}
