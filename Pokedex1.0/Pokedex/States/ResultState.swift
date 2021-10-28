//
//  ResultState.swift
//  Pokedex
//
//  Created by sun on 2021/10/28.
//

import Foundation


// will change UI according to this state
enum ResultState {
    case loading
    case success(content: [PokemonViewModel])
    case failed(error: Error)
}
