//
//  FinishVieModel.swift
//  Effective Mobile
//
//  Created by Fanil_Jr on 13.01.2024.
//

import Foundation

class FinishViewModel {
    
    var title: String
    var start: (() -> Void)?
    
    enum Action {
        case start
    }
    
    init(title: String) {
        self.title = title
    }
    
    func push(_ action: Action) {
        switch action {
        case .start:
            start?()
        }
    }
}
