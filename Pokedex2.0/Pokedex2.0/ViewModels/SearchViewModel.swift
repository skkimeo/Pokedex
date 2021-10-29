//
//  SearchViewModel.swift
//  Pokedex2.0
//
//  Created by sun on 2021/10/29.
//

import SwiftUI
import Combine

// convert Pokemon into PokemonViewModels
// publish searchQuery
// and update [PokemonViewModel] accordingly
class SearchViewModel: ObservableObject {
    @Published var searchQuery = ""
    // CHANGE THIS TO AN OPTIONAL TO IMPLEMENT PROGRESSVIEW
    // for searchView
    @Published public private(set) var pokemons = [PokemonViewModel]()
    
    // for poketView
    @Published var myPokemons: [PokemonViewModel]?
    
    private let service = Service()
    private var disposables = Set<AnyCancellable>()
    private let imageLoader = ImageLoader()
    
    // make searchQuery observable and fetch data in accordance
    init() {
        $searchQuery
            .removeDuplicates()
            .debounce(for: 0.7, scheduler: RunLoop.main)
            // action to do on the fetched API data
            .sink(receiveValue: loadPokemons(of:))
            .store(in: &disposables)
    }
    
    
    // MARK: - Search
    // fetch data from API
    // completion is what u do to the fetched data
    // in this case, convert it into PokemonViewModel
    private func loadPokemons(of searchQuery: String) {
        // MAYBE ADD STH FOR WHEN THE SEARTQUERY is EMPTY?
        pokemons.removeAll()
        imageLoader.reset()
        
        service.loadPokemons(searchTerm: searchQuery) { pokemons in
            pokemons.forEach { self.appendPokemonVM(of: $0) }
        }
    }
    
    // convert Pokemon into ViewModel and append the ViewModel
    private func appendPokemonVM(of pokemon: Pokemon) {
        let pokemonVM = PokemonViewModel(pokemon: pokemon)
        
        if myPokemons?.contains(pokemonVM) == true {
            pokemonVM.isSaved = true
        }
        // b/c causes the UI to change
        DispatchQueue.main.async {
            self.pokemons.append(pokemonVM)
        }
        
        imageLoader.loadImage(for: pokemon) { image in
            DispatchQueue.main.async {
                pokemonVM.profileImage = image
            }
        }
    }
    
    // MARK: - Storing and Fetching Saved Data
    private func saveMyPokemons() {
        // save..
    }
    
    private func fetchMyPokemons() {
        //
    }
    
    
    // MARK: - Intent(s)
    func addToMyPoket(_ pokemon: PokemonViewModel) {
        if myPokemons == nil {
            myPokemons = []
        }
        
        if !myPokemons!.contains(pokemon) {
            myPokemons?.append(pokemon)
        }
        
    }
    
    func deleteFromMyPoket(_ pokemon: PokemonViewModel) {
        // 이러면 저장이 안될 것 같은 느낌...
        if myPokemons != nil {
            myPokemons?.remove(at: (myPokemons?.firstIndex(where: { $0.id == pokemon.id }))!)
        }
    }
    
    func toggleSaveStatus(of pokemon: PokemonViewModel) {
        pokemon.isSaved.toggle()
        pokemon.isSaved ? addToMyPoket(pokemon) : deleteFromMyPoket(pokemon)
    }
}
