//
//  HomeView.swift
//  Pokedex
//
//  Created by sun on 2021/10/28.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        TabView {
            Text("this is the Favorites View")
                .tabItem {
                    Image(systemName: "star")
                    Text("My Pokemons")
                }
            
            Text("this is the Search View")
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
