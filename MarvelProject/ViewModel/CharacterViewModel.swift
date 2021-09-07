//
//  CharacterViewModel.swift
//  MarvelProject
//
//  Created by Furkan Başoğlu on 4.09.2021.
//

import Foundation

protocol CharacterViewModelDelegate: class {
    func willStartLoad()
    func willFinsihLoad()
    func didFinsihLoad()
    func didFinsihLoad(with error: NSError)
}

class CharacterViewModel {
    
    weak var delegate: CharacterViewModelDelegate?

    private var apiService :ApiService
    var completion :() -> () = {  }
    var searchCompletion :() -> () = {  }

    private var characters = [Character]()
    private var filterCharacters = [Character]()
     var isFilter = false

    private var characterData: CharacterDataWrapper? {
        didSet { self.didUpdateCharacterData() }
    }
    
    private let itemsPerPage: Int = 20
    private var currentPage: Int = -1
    private var currentName: String?
    
    var numberOfCharacters: Int {
        if isFilter {
            return filterCharacters.count
        }else{
            return characters.count
        }
    }
    
    var title: String {
        return "Characters"
    }
    
    var isFirstLoad: Bool {
        return currentPage == -1
    }
    
    var isSearching: Bool {
        return !(currentName?.isEmpty ?? true)
    }
    
    func loadCharacters() {
        
        guard isFirstLoad else {
            return
        }
        
        loadCharacters(at: 0)
    }
    
    func loadNextPage() {
        loadCharacters(name: currentName, at: (currentPage + 1))
    }
    
    func reload() {
        reset()
        loadCharacters()
    }
    
    func reset() {
        currentPage = -1
        currentName = nil
        characterData = nil
    }
    
    func searchCharacter(with name: String) {
        isFilter = true
        if name.count == 0 {
            self.filterCharacters = []
                self.filterCharacters = self.characters
        } else {
             filterCharacters = self.characters.filter({$0.name!.localizedCaseInsensitiveContains("\(name)")})
            print("filterCharacters:\(filterCharacters.count)")
        }
        searchCompletion()
        
       // currentName = name
       // loadCharacters(name: currentName, at: 0)
    }
    
    
    init(apiService :ApiService) {
        self.apiService = apiService
    }
    
    private func didUpdateCharacterData() {
        
        if currentPage >= 1 {
            characters.append(contentsOf: characterData?.data?.results ?? [])
        } else {
            characters = characterData?.data?.results ?? []
        }
        self.completion()
        
    }
    
    private func loadCharacters(name: String? = nil, at page: Int) {
        
        guard self.currentPage != page else {
            return
        }
        
        delegate?.willStartLoad()
        self.apiService.character(name, page: page) { (result) in
            self.delegate?.willFinsihLoad()
            
            switch result {
            case let .success(characterData):
                self.currentPage = page
                self.currentName = name
                self.characterData = characterData
                
                if (self.characters.isEmpty && (self.currentPage == 0)) {
                } else {
                    self.delegate?.didFinsihLoad()
                }
                
            case let .failure(error):
                
                if self.isFirstLoad {
                    self.delegate?.didFinsihLoad(with: error)
                } else {
                    DispatchQueue.main.async {
                       // self.logic.showError(error: error, retry: nil, onDismiss: nil)
                    }
                }
            }
        }
    }

    func character(at indexPath: IndexPath) -> Character? {
        
        if isFilter {
            return (indexPath.row < filterCharacters.count) ? filterCharacters[indexPath.item] : nil
        }else{
            return (indexPath.row < characters.count) ? characters[indexPath.item] : nil
        }
    }
    
    func viewModel(at indexPath: IndexPath) -> Any? {
    
        guard let character = character(at: indexPath) else {
            return nil
        }
        
        return CharacterCollectionVCModel(character: character, favorited: self.isFavorite(character: character))
    }
    
    
}

extension CharacterViewModel {
    
    func isFavorite(character: Character) -> Bool {
        return GFunctions.shared.isFavorited(character)
    }
    
}

