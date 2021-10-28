//
//  SearchRowView.swift
//  Pokedex
//
//  Created by sun on 2021/10/28.
//

import SwiftUI

struct SearchRowView: View {
    @ObservedObject var pokemonData: PokemonViewModel
    var body: some View {
        VStack {
            Text(pokemonData.name)
//            Text(pokemonData.id)
            pokemonData.image ?? Image(systemName: "star")
        }
    }
}

//struct SearchRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchRowView()
//    }
//}
