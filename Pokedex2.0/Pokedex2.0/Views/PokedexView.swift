//
//  PokedexView.swift
//  Pokedex2.0
//
//  Created by sun on 2021/10/29.
//

import SwiftUI

struct PokedexView: View {
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
        ContentView()
    }
}
