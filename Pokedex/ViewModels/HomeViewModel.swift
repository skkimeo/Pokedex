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
    
    func searchPokemons() {
        
        let url = "https://pokeapi.co/api/v2/pokemon/\(searchQuery)"
        print(URL(string: url)!)
        
        URLSession.shared.dataTask(with: URL(string: url)!) { data, response, error in
            if let error = error {
                print("error")
                return
            }
            
            guard let APIdata = data else {
                print("No Data Found")
                return
            }
            
            do {
                let pokemons = try JSONDecoder().decode(Pokemon.self, from: APIdata)
                DispatchQueue.main.async {
                    if self.pokemons.isEmpty {
                        self.pokemons = [pokemons]
                    }
                }
                print("success")
            } catch {
                print("decoding error")
            }
            
        }
        .resume()
    }
}
