//
//  HomeViewModel.swift
//  Pokedex
//
//  Created by sun on 2021/10/28.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var searchQuery = ""
    
    var searchCancellable: AnyCancellable? = nil
    
    
    init() {
        searchCancellable = $searchQuery
            .removeDuplicates()
            .decode(type: 0.7, decoder: RunLoop.main)
            .sink { result in
                switch result {
                    case
                }
                
            }
    }
}
