//
//  TranslateViewModel.swift
//  EasyEnglish
//
//  Created by 김성률 on 9/19/24.
//

import Foundation
import Combine

final class TranslateViewModel: ObservableObject {
    
    var cancellables = Set<AnyCancellable>()
    var input = Input()
    @Published var output = Output()
    
    struct Input {
        let inputText = PassthroughSubject<String, Never>()
    }
    
    struct Output {
        var translatedText: String = ""
    }
    
    func translate() {
        
    }
    
}
