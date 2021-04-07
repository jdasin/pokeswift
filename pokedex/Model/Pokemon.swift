//
//  Pokemon.swift
//  pokedex
//
//  Created by Admin on 4/5/21.
//

import Foundation
struct Pokemon {
    var id: Int?
    var name: String?
    var imageUrl: String?
    init() {}
    init(id: Int?, name: String?, imageUrl: String?) {
        self.id = id
        self.name = name
        self.imageUrl = imageUrl
    }
    
}
