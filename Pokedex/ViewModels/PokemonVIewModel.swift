//
//  PokemonVIewModel.swift
//  Pokedex
//
//  Created by sun on 2021/10/28.
//

import SwiftUI

class PokemonViewModel: ObservableObject, Identifiable {
    let id: Int
    let name: String
    
    //make Published if this doesn't work
    @Published var image: Image?
    
    init(pokemon: Pokemon) {
        self.id = pokemon.id
        self.name = pokemon.name
    }
    
}
