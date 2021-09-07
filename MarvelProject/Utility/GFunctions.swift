//
//  GFunctions.swift
//  MarvelProject
//
//  Created by Furkan Başoğlu on 4.09.2021.
//

import Foundation

class GFunctions: NSObject {
    
    static let shared: GFunctions = GFunctions()
    
    func isFavorited(_ character: Character) -> Bool {
        if let id = character.id {
           return (UserDefaults.standard.object(forKey: "\(id)") as? Bool) ?? false
        } else {
            return false
        }
    }
    
    func favorite(_ character: Character) -> Bool {
        if let id = character.id {
            UserDefaults.standard.set(true, forKey: "\(id)")
            return isFavorited(character)
        } else {
            return false
        }
    }
    
    func unfavorite(_ character: Character) -> Bool {
        if let id = character.id {
            UserDefaults.standard.removeObject(forKey: "\(id)")
            return !isFavorited(character)
        } else {
            return true
        }
    }
    

}
