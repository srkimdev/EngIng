//
//  DiaryReviseViewModel.swift
//  EasyEnglish
//
//  Created by 김성률 on 10/3/24.
//

import Foundation
import Combine
import UIKit

final class DiaryReviseViewModel: ObservableObject {
    
    private var cancellables = Set<AnyCancellable>()
    
    let input = Input()
    @Published
    var output = Output()
    
    struct Input {
        let uploadImage = PassthroughSubject<Date, Never>()
    }
    
    struct Output {
        var showImage: UIImage = UIImage(systemName: "star")!
    }
    
    init() {
        
        input.uploadImage
            .sink { value in
                self.output.showImage = FilesManager.shared.loadImageToDocument(filename: DateFormatManager.shared.getyymmdd(value))!
            }
            .store(in: &cancellables)
        
    }
    
}
