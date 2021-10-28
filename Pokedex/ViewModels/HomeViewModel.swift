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
    @Published private(set) var pokemons = [PokemonViewModel]()
    private let imageLoader = ImageLoader()
    
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
    
    func searchPokemons() {
        pokemons = []
        imageLoader.reset()
        
        let url = "https://pokeapi.co/api/v2/pokemon/\(searchQuery)"
        print(URL(string: url)!)
        
        URLSession.shared.dataTask(with: URL(string: url)!) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let APIdata = data else {
                print("No Data Found")
                return
            }
            
            do {
                let pokemons = try JSONDecoder().decode(Pokemon.self, from: APIdata)
                print(pokemons.name)
                DispatchQueue.main.async {
                    if self.pokemons.isEmpty {
                        self.appendPokemonViewModel(for: pokemons)
                    }
                }
                print("success")
            } catch {
                print("decoding error")
            }
            
        }
        .resume()
    }
    
    private func appendPokemonViewModel(for pokemon: Pokemon) {
        let pokemonViewModel = PokemonViewModel(pokemon: pokemon)
        DispatchQueue.main.async {
            self.pokemons.append(pokemonViewModel)
        }
        
        imageLoader.loadImage(for: pokemon) { image in
            DispatchQueue.main.async {
                pokemonViewModel.image = image
            }
            
        }
        print(pokemonViewModel.id)
        
    }
}
