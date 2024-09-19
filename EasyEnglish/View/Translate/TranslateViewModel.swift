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
    
    init() {
        
        input
            .inputText
            .sink { value in
                print(value)
                Task {
                    await self.translate(text: value)
                }
            }
            .store(in: &cancellables)
        
    }
    
    func translate(text: String) async {
        let query = TranslateQuery(text: [text], target_lang: "EN")
        let result = await NetworkManager.shared.requestAPI(router: Router.translate(query: query), type: TranslateResponse.self)
        
        switch result {
        case .success(let value):
            DispatchQueue.main.async {
                self.output.translatedText = value.translations.first?.text ?? ""
            }
        case .failure(let error):
            print(error)
        }
    }
    
}
