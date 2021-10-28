//
//  SearchView.swift
//  Pokedex
//
//  Created by sun on 2021/10/28.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject var homeData: HomeViewModel
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
             searchBarBody
            // searchResultsView
            
        }
    }
    
    var searchBarBody: some View {
        HStack(spacing: 10) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            TextField("Search Pokemon", text: $homeData.searchQuery)
                .autocapitalization(.none)
                .disableAutocorrection(true)
            
        }
        .padding(.vertical, 10)
        .padding(.horizontal)
        .background(Color.white)
        .shadow(color: .black.opacity(0.06), radius: 5, x: 5, y: 5)
        .shadow(color: .black.opacity(0.06), radius: 5, x: -5, y: -5)

    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
