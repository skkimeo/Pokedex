//
//  HomeViewModel.swift
//  Pokedex
//
//  Created by sun on 2021/10/28.
//

import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    @Published var searchQuery = ""
    
    @Published var state: ResultState = .loading
    
    // make this @Published if doesn't update
    private(set) var pokemons = [Pokemon]()
    
    var searchCancellable: AnyCancellable? = nil
    
    
    init() {
        searchCancellable = $searchQuery
            .removeDuplicates()
            .debounce(for: 0.7, scheduler: RunLoop.main)
            .sink { result in
                switch result {
                case .finished:
                    self.state = .success(content: self.pokemons)
                    break
                case .failure(let error):
                    self.state = .failed(error: error)
                    break
                }
            } receiveValue: { str in
                if str == "" {
                    self.pokemons = []
                } else {
                    self.searchPokemons()
                }
            }
    }
}
