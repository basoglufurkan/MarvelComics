//
//  CharacterDetailViewModel.swift
//  MarvelProject
//
//  Created by Furkan Başoğlu on 4.09.2021.
//

import Foundation

class CharacterDetailViewModel{
    
    //private let logic: CharacterDetailLogic
    private let character: Character
    private var sectionKeys = [NSNumber]()
    private var sections = [NSNumber: CharacterDetailSection]() {
        didSet { sectionKeys = Array(sections.keys.sorted(by: { $0.compare($1) == .orderedAscending })) }
    }
    
    var numberOfSections: Int {
        return sections.count
    }
   
    
    init(character: Character) {
       // self.logic = logic
        self.character = character
    }
    
    func getHeaderModel() ->CharacterDetailHeaderModel  {
        return CharacterDetailHeaderModel(character: character, favorited: GFunctions.shared.isFavorited(character))
    }
    
    func loadCharacterData() {
        sections[NSNumber(value: 0)] = .comics(viewModels: character.comics?.items?.map({ CharacterSectionContent(comic: $0) }) ?? [], preview: true)
        sections[NSNumber(value: 1)] = .series(viewModels: character.series?.items?.map({ CharacterSectionContent(serie: $0) }) ?? [], preview: true)
        sections[NSNumber(value: 2)] = .stories(viewModels: character.stories?.items?.map({ CharacterSectionContent(story: $0) }) ?? [], preview: true)
        sections[NSNumber(value: 3)] = .events(viewModels: character.events?.items?.map({ CharacterSectionContent(event: $0) }) ?? [], preview: true)
    }
    
    func numberOfRows(at section: Int) -> Int {
        
        let detailSection = characterDetailSection(at: IndexPath(row: 0, section: section))
        let rows = detailSection.numberOfRows
        print("rows:\(rows)")
        switch rows {
        case _ where rows == 0:
            return 1
        default:
            return rows
        }
    }
    
    func canShowContent(for section: CharacterDetailSection, at indexPath: IndexPath) -> Bool {
        
        guard (section.numberOfRows > indexPath.row) else {
            return false
        }
        return (section.numberOfRows != indexPath.row)
    }
    
    func characterDetailSectionKey(at section: Int) -> NSNumber {
        return sectionKeys[section]
    }
    
    func characterDetailSection(at indexPath: IndexPath) -> CharacterDetailSection {
        return sections[characterDetailSectionKey(at: indexPath.section)]!
    }
    
    func titleForHeader(at section: Int) -> String? {
        return characterDetailSection(at: IndexPath(row: 0, section: section)).headerTitle
    }
    
    func viewModelForCell(at indexPath: IndexPath) -> Any? {
        
        let section = characterDetailSection(at: indexPath)
        
        guard canShowContent(for: section, at: indexPath) else {
            if indexPath.row == 0 {
                return NoContent(title: section.noContentMessageTitle)
            }
            return nil
        }
        
        return section.viewModel(at: indexPath.row)
    }
        
    func indexPathForAction(at indexPath: IndexPath) -> IndexPath {
        let section = characterDetailSection(at: indexPath)
           return IndexPath(row: section.numberOfRows, section: indexPath.section)
    }
    
    
}


private extension CharacterDetailHeaderModel {
    init(character: Character, favorited: Bool) {
        self.init(
            title: character.name,
            description: character.description,
            imageURL: character.thumbnail?.url,
            favorited: favorited
        )
    }
}

private extension CharacterSectionContent {
    
    init(comic: ComicSummary) {
        self.init(title: comic.name, imageURL: nil)
    }
    
    init(story: StorySummary) {
        self.init(title: story.name, imageURL: nil)
    }
    
    init(event: EventSummary) {
        self.init(title: event.name, imageURL: nil)
    }
    
    init(serie: SeriesSummary) {
        self.init(title: serie.name, imageURL: nil)
    }

}
