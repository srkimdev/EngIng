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
    
    var cancellables = Set<AnyCancellable>()
    var input = Input()
    @Published var output = Output()
    
    let repository = RealmRepository<CategoryTable>()
    
    struct Input {
        let carouselTap = CurrentValueSubject<Int, Never>(0)
    }
    
    struct Output {
        var selectedCategory = CategoryTable()
    }
    
    init() {
        input.carouselTap
            .sink { value in
                self.output.selectedCategory = self.categories[value]
            }
            .store(in: &cancellables)
    }
    
}
