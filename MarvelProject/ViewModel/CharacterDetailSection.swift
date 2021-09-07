//
//  CharacterDetailSection.swift
//  MarvelProject
//
//  Created by Furkan Başoğlu on 4.09.2021.
//

import Foundation

enum CharacterDetailSection {
    case comics(viewModels: [CharacterSectionContent], preview: Bool)
    case events(viewModels: [CharacterSectionContent], preview: Bool)
    case stories(viewModels: [CharacterSectionContent], preview: Bool)
    case series(viewModels: [CharacterSectionContent], preview: Bool)
}
 
extension CharacterDetailSection {
    
    var headerTitle: String?  {
        switch self {
        case .comics:
            return "Comics characters"
        case .events:
            return "Events"
        case .stories:
            return "Story Names"
        case .series:
            return "TV Series"
        }
    }
    
    var numberOfRows: Int {
        return viewModels.count
    }
    
    var viewModels: [Any] {
        switch self {
        case let .comics(viewModels, _),
             let .series(viewModels, _),
             let .stories(viewModels, _),
             let .events(viewModels, _):
            return viewModels
        }
    }
    
    var callToActionTitle: String {
        return preview ? "Show more" : "Show less"
    }
    
    var noContentMessageTitle: String {
        switch self {
        case .comics:
            return "No Comics"
        case .events:
            return "No Events"
        case .stories:
            return "No Stories"
        case .series:
            return "No Series"
        }
    }
    
    var preview: Bool {
        switch self {
        case
             let .comics(_, preview),
             let .series(_, preview),
             let .stories(_, preview),
             let .events(_, preview):
            return preview
        }
    }
    
    func viewModel(at row: Int) -> Any? {
        
        switch self {
        case let .comics(viewModels, _),
             let .series(viewModels, _),
             let .stories(viewModels, _),
             let .events(viewModels, _):
            return viewModels[row]
        }
    }
}
