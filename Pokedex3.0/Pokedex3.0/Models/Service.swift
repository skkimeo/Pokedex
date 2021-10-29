//
//  Service.swift
//  Pokedex3.0
//
//  Created by sun on 2021/10/29.
//

import Foundation

// sends request to fetch data from the API
class Service {
    // fetch data -> modify via the completion handler
    private var dataTask: URLSessionDataTask?
    private var baseUrl = "https://pokeapi.co/api/v2/pokemon/"
    
    // fetch pokemons from the api
    func loadPokemons(searchTerm: String, completion: @escaping ([Pokemon]) -> Void) {
        // cancel any running task
        dataTask?.cancel()
        
        // build URL based on searchTerm
        guard let url = buildURL(for: searchTerm) else {
            completion([])
            return
        }
        
        // if URL is built, create a new DataTask
        dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                completion([])
                return
            }
            
            guard let response = response as? HTTPURLResponse,
            let APIdata = data else {
                print("unknown APIerror")
                completion([])
                return
            }
            print(APIdata.first!)
            
            // everything went fine so decode now!
            if (20...299).contains(response.statusCode) {
                // change here if fetch fails
                if let pokemonResponse = try? JSONDecoder().decode(Pokemon.self, from: APIdata) {
                    completion([pokemonResponse])
                } else {
                    print("API data decoding error")
                    completion([])
                }
            } else {
                print("wrong response status code")
                completion([])
            }
        }
        
        dataTask?.resume()
    }
    
    private func buildURL(for searchTerm: String) -> URL? {
        guard !searchTerm.isEmpty else { return nil }
        
        let url = "\(baseUrl)\(searchTerm)"
        
        return URL(string: url)
    }
}
