//
//  HomeView.swift
//  Pokedex
//
//  Created by sun on 2021/10/28.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var homeData = HomeViewModel()
    
    var body: some View {
        TabView {
            Text("this is the Favorites View")
                .tabItem {
                    Image(systemName: "star")
                    Text("My Pokemons")
                }
            
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
                .environmentObject(homeData)
                .padding()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
