//
//  CharacterOption.swift
//  MarvelProject
//
//  Created by Furkan Başoğlu on 4.09.2021.
//

import Foundation

enum CharacterOption: CaseIterable {
    case favorite
    case unfavorite
}

extension CharacterOption {
    
    var title: String {
        switch self {
        case .favorite:
            return "Favorite"
        case .unfavorite:
            return "Remove from favorites"
        }
    }
    
}
