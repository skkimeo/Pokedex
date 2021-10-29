//
//  SearchBarView.swift
//  Pokedex3.0
//
//  Created by sun on 2021/10/29.
//

import SwiftUI

struct SearchBarView: View {
    @EnvironmentObject var viewModel: SearchViewModel
    
    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            TextField("gotta catch them all..!", text: $viewModel.searchQuery)
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












struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView()
    }
}
