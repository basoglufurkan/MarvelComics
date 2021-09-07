//
//  EventList.swift
//  MarvelProject
//
//  Created by Furkan Başoğlu on 4.09.2021.
//

import Foundation

struct EventList {
    
    let available: Int?
    let returned: Int?
    let collectionURI: String?
    let items: [EventSummary]?
    
    enum CodingKeys: String, CodingKey {
        case available
        case returned
        case collectionURI
        case items
    }
}

extension EventList: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.available = try container.decodeIfPresent(Int.self, forKey: .available)
        self.returned = try container.decodeIfPresent(Int.self, forKey: .returned)
        self.collectionURI = try container.decodeIfPresent(String.self, forKey: .collectionURI)
        self.items = try container.decodeIfPresent([EventSummary].self, forKey: .items)
    }
}

extension EventList: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(available, forKey: .available)
        try container.encodeIfPresent(collectionURI, forKey: .collectionURI)
        try container.encodeIfPresent(returned, forKey: .returned)
        try container.encodeIfPresent(items, forKey: .items)
    }
}
