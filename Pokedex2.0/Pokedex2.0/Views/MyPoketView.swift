//
//  MyPoketView.swift
//  Pokedex2.0
//
//  Created by sun on 2021/10/29.
//

import SwiftUI

struct MyPoketView: View {
    @EnvironmentObject var viewModel: SearchViewModel
    
    var body: some View {
        NavigationView {
            Group {
                if let myPokemons = viewModel.myPokemons {
                    ScrollView(.vertical, showsIndicators: false) {
                        ForEach(myPokemons) { pokemon in
                            Text(pokemon.name)
                        }
                    }
                } else {
                    VStack(spacing: 20) {
                        Spacer()
                        Image(systemName: "star")
                            .font(.largeTitle)
                            .foregroundColor(.blue)
                        Text("Go Search Them All...!")
                            .foregroundColor(.gray)
                        Spacer()
                    }
                }
            }
            .navigationBarTitle("My Pokét!")
        }
    }
}














struct MyPoketView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}