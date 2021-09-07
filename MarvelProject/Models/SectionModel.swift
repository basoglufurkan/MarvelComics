//
//  SectionModel.swift
//  MarvelProject
//
//  Created by Furkan Başoğlu on 4.09.2021.
//

import Foundation

struct CharacterDetailHeaderModel{
    let title: String?
    let description: String?
    let imageURL: URL?
    let favorited: Bool
}


struct CharacterSectionContent {
    let title: String?
    let imageURL: URL?
}

struct NoContent {
    let title: String
}
