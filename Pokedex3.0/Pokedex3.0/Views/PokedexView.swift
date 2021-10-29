//
//  PokedexView.swift
//  Pokedex3.0
//
//  Created by sun on 2021/10/29.
//

import SwiftUI
import CoreData

struct PokedexView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(
        entity: PokemonEntity.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \PokemonEntity.name, ascending: true)]
    ) var pokemonEntity: FetchedResults<PokemonEntity>
    
    @StateObject var viewModel = SearchViewModel()
    
    var body: some View {
        TabView {
            MyPoketView()
                .tabItem {
                    Image(systemName: "star")
                    Text("My Pokét")
                }
                
            
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
        }
        .environmentObject(viewModel)
    }
    
    
}












struct PokedexView_Previews: PreviewProvider {
    static var previews: some View {
        PokedexView()
    }
}
