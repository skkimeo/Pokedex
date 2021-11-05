//
//  ContentView.swift
//  Pokedex2.0
//
//  Created by sun on 2021/10/29.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        PokedexView()
            .font(Font.custom("pixelmix", size: 15))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
