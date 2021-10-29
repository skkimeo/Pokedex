//
//  SearchRowView.swift
//  Pokedex2.0
//
//  Created by sun on 2021/10/29.
//

import SwiftUI

struct SearchRowView: View {
    @EnvironmentObject var viewModel: SearchViewModel
    @ObservedObject var pokemon: PokemonViewModel
    
    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            profileImageView(image: pokemon.profileImage)
            
            VStack(alignment: .leading, spacing: 8) {
                Spacer()
                HStack {
                    Group {
                        Text(String(pokemon.id))
                            .foregroundColor(.purple)
                            .fontWeight(.bold)
                        Text(pokemon.name)
                            .fontWeight(.bold)
                        Spacer()
                        saveButton
                        Spacer()
                    }
//                    .multilineTextAlignment(.leading)
                }
                Spacer()
                HStack {
                    Text("height: \(String(pokemon.height))")
                    Text("weight: \(String(pokemon.weight))")
                }
                .font(.subheadline)
                .multilineTextAlignment(.leading)
                Spacer()
                
            }
            .padding(.vertical)
            Spacer(minLength: 0)
            
        }
        .background(Color(.systemIndigo).opacity(0.15))
        .cornerRadius(25)
        .padding(.horizontal)
    }
    
    var saveButton: some View {
        Button {
            viewModel.toggleSaveStatus(of: pokemon)
            // save to MyPoket
            // try to add toggle action?
            // colored if isSaved... 
        } label: {
            Image(systemName: pokemon.isSaved ? "star.fill" : "star")
                .foregroundColor(.blue)
        }
    }
}













struct SearchRowView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
