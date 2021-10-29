//
//  SearchView.swift
//  Pokedex3.0
//
//  Created by sun on 2021/10/29.
//

import SwiftUI
import CoreData

struct SearchView: View {
    @EnvironmentObject var viewModel: SearchViewModel
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(
        entity: PokemonEntity.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \PokemonEntity.name, ascending: true)]
    ) var pokemonEntity: FetchedResults<PokemonEntity>
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    SearchBarView()
                        .padding()
                        .environmentObject(viewModel)
                    
                    // change the SearchViewModel to implement ProgressView
                    ForEach(viewModel.pokemons) { pokemon in
                        SearchRowView(pokemon: pokemon)
                            .environmentObject(viewModel)
                    }
                }
                .listStyle(.inset)
            }
            .navigationBarTitle("Find A Pokémon!")
        }
    }
}













struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        PokedexView()
    }
}
