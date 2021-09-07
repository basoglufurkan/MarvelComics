//
//  MarvelAPI.swift
//  MarvelProject
//
//  Created by Furkan Başoğlu on 4.09.2021.
//

import Foundation

class MarvelAPI {
    /*
     baseURL: URL(string: "https://gateway.marvel.com:443")!,
     privateKey: "76cb8d0bd88b49abe3e4d049e6064518062f998c",
     apiKey: "1951bc8fc24c16592930f688c6df1581"
     
    let publicKey = "d6e67771efc843231ab9f66d4b36cbef"
    let privateKey = "faa6a5dc47632fd76938bcbc5857b42864e6b521"
    let ts = NSDate().timeIntervalSince1970.description
    let hash = MD5(string: "\(ts)\(privateKey)\(publicKey)")
    */
    static let shared = MarvelAPI(
        baseURL: URL(string: "https://gateway.marvel.com:443")!,
        privateKey: "faa6a5dc47632fd76938bcbc5857b42864e6b521",
        apiKey: "d6e67771efc843231ab9f66d4b36cbef"
        
    )

    lazy var characterService: ApiService = {
        return ApiService(baseURL: baseURL, privateKey: privateKey, apiKey: apiKey)
    }()
    
    private let baseURL: URL
    private let privateKey: String
    private let apiKey: String
    
    init(baseURL: URL, privateKey: String, apiKey: String) {
        self.baseURL = baseURL
        self.privateKey = privateKey
        self.apiKey = apiKey
    }
    
}
