//
//  Pokemon.swift
//  Pokedex3.0
//
//  Created by sun on 2021/10/29.
//

import Foundation

struct PokemonResponse: Codable {
    var pokemons: [Pokemon]
}

struct Pokemon: Codable {
    let name: String
    let id: Int
    let height: Int
    let weight: Int
}
