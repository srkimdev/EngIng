//
//  DiaryWriteViewModel.swift
//  EasyEnglish
//
//  Created by 김성률 on 9/25/24.
//

import Foundation
import Combine
import PhotosUI
import SwiftUI

final class DiaryWriteViewModel: ObservableObject {
    
    var cancellables = Set<AnyCancellable>()
    var input = Input()
    @Published var output = Output()
    
    @Published var titleText = ""
    @Published var storyText = ""
    @Published var photosPickerItem: PhotosPickerItem? = nil
    @Published var savedImage: UIImage? = nil
    
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
        
        if titleText.isEmpty || storyText.isEmpty || savedImage == nil {
            self.output.isAllowed = false
        } else {
            FilesManager.shared.saveImageToDocument(image: savedImage!, filename: DateFormatManager.shared.getyymmdd(Date()))
            repository.createItem(DiaryTable(title: titleText, content: storyText))
            self.output.isAllowed = true
        }
        
    }
    
    func handlePickerItemChange() async {
        if let photosPickerItem = photosPickerItem,
           let data = try? await photosPickerItem.loadTransferable(type: Data.self) {
            if let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.savedImage = image
                }
            }
        }
        DispatchQueue.main.async {
            self.photosPickerItem = nil
        }
    }
    
}
