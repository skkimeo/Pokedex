//
//  PokemonViewModel.swift
//  Pokedex2.0
//
//  Created by sun on 2021/10/29.
//

import SwiftUI

class PokemonViewModel: ObservableObject, Identifiable, Equatable {
    static func == (lhs: PokemonViewModel, rhs: PokemonViewModel) -> Bool {
        lhs.id == rhs.id
    }
    
    let id: Int
    let name: String
    let height: Int
    let weight: Int
    @Published var isSaved = false
    
    // this is b/c gonna fetch from URL
    // so we have to publish it when the image is actually fetched
    @Published var profileImage: Image?
    
    init(pokemon: Pokemon) {
        self.name = pokemon.name
        self.id = pokemon.id
        self.height = pokemon.height
        self.weight = pokemon.weight
    }
}
