//
//  Pokemon.swift
//  Pokedex
//
//  Created by sun on 2021/10/28.
//

import Foundation


// response
struct Pokemons: Codable {
    var pokemons: [Pokemon]
}

struct Pokemon: Identifiable, Codable {
    let id: Int
    let name: String
    let imgUrl: String
//    let types: [String]
//    let height: Int
//    let weight: Int
    
    enum codingKeys: String, CodingKey {
        case id, name
        case imgUrl = "sprites"
    }
}
