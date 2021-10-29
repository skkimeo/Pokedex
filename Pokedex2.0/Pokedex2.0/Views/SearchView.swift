//
//  SearchView.swift
//  Pokedex2.0
//
//  Created by sun on 2021/10/29.
//

import SwiftUI

struct SearchView: View {
//    @StateObject var viewModel = SearchViewModel()
    @EnvironmentObject var viewModel: SearchViewModel
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                SearchBarView()
                    .padding()
                    .environmentObject(viewModel)
                
                // change the SearchViewModel to implement ProgressView
                ForEach(viewModel.pokemons) { pokemon in
                    SearchRowView(pokemon: pokemon)
                        .environmentObject(viewModel)
                }
            }
            .navigationBarTitle("Find A Pokémon!")
        }
    }
}





struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}