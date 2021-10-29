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
    var num = 0
    @Published var searchQuery = ""
    // CHANGE THIS TO AN OPTIONAL TO IMPLEMENT PROGRESSVIEW
    // for searchView
    @Published public private(set) var pokemons = [PokemonViewModel]()
    
    // for poketView
    @Published var myPokemons: [PokemonViewModel]? {
        didSet {
            if myPokemons != oldValue {
                num += 1
                print("updated my Poket: \(String(num))")
                saveMyPokemons()
            }
        }
    }
    
//    @Published var savedPokemons: [Pokemon]?
    
    private let myKey = "myKey"
    
    private let service = Service()
    private var disposables = Set<AnyCancellable>()
    private let imageLoader = ImageLoader()
    
    // make searchQuery observable and fetch data in accordance
    init() {
        fetchMyPokemons()
        
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
        var savedPokemons: [Pokemon]?

        if let myPokemons = myPokemons, !myPokemons.isEmpty {
        // should i just mske savedPokemons empty instead...?
        // would decoding crash..?
            savedPokemons = []
        myPokemons.forEach { savedPokemons!.append(Pokemon(name: $0.name, id: $0.id, height: $0.height, weight: $0.weight)) }
        }
        
//        print(savedPokemons.count)
//        if !savedPokemons.isEmpty {
//        print(savedPokemons.first!.name)
//        }
        
//        savedPokemons.forEach {print($0.name)}
        if let encodedData = try? JSONEncoder().encode(savedPokemons) {
            UserDefaults.standard.set(encodedData, forKey: myKey)
        } else {
            print("encoding error")
        }
    }
    
    private func fetchMyPokemons() {
        guard
            let data = UserDefaults.standard.data(forKey: myKey),
            let savedPokemons = try? JSONDecoder().decode([Pokemon].self, from: data)
        else { return }
        
        savedPokemons.forEach { addToMyPoket(PokemonViewModel(pokemon: $0)) }
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
        if myPokemons != nil {
            myPokemons?.remove(at: (myPokemons?.firstIndex(where: { $0.id == pokemon.id }))!)
        }
    }
    
    func toggleSaveStatus(of pokemon: PokemonViewModel) {
        pokemon.isSaved.toggle()
        pokemon.isSaved ? addToMyPoket(pokemon) : deleteFromMyPoket(pokemon)
    }
}
