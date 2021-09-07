//
//  CharacterCollectionVCModel.swift
//  MarvelProject
//
//  Created by Furkan Başoğlu on 4.09.2021.
//

import Foundation

struct CharacterCollectionVCModel {
    let title: String?
    let imageURL: URL?
    let favorited: Bool
}

extension CharacterCollectionVCModel {
    init(character: Character, favorited: Bool) {
        self.title = character.name
        self.imageURL = character.thumbnail?.url
        self.favorited = favorited
    }
}
