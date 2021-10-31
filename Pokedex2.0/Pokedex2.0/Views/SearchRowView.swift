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
        ZStack {
        HStack(alignment: .top, spacing: 15) {
            ProfileImageView(image: pokemon.profileImage)
            
            VStack(alignment: .leading, spacing: 8) {
                Spacer()
                HStack {
                    Group {
                        Text(String(pokemon.id))
                            .foregroundColor(.purple)
                            .fontWeight(.bold)
                        Text(pokemon.name)
                            .fontWeight(.bold)
                        //                        Spacer()
                        saveButton
                        //                        Spacer()
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
        .onTapGesture(count: 2){
            withAnimation {
                viewModel.toggleSaveStatus(of: pokemon)
            }
        }
            heartButton
                .opacity(pokemon.isSaved ? 1 : 0)
        }
        //        .padding(.horizontal)
    }
    
    var heartButton: some View {
        Image(systemName: "heart.fill")
            .foregroundColor(.pink)
            .font(.largeTitle)
//            .scaleEffect()
            .scaleEffect(pokemon.isSaved ? 0 : 1)
    }
    
    var saveButton: some View {
        
        //        Button {
        //            viewModel.toggleSaveStatus(of: pokemon)
        //            // save to MyPoket
        //            // try to add toggle action?
        //            // colored if isSaved...
        //        } label: {
        withAnimation {
            ZStack {
                Image(systemName: "heart")
                    .foregroundColor(.pink)
                if pokemon.isSaved {
                    Image(systemName: "heart.fill")
                        .foregroundColor(.pink)
                        .transition(AnyTransition.asymmetric(insertion: .scale, removal: .scale))
                        .scaleEffect()
                }
                //            Image(systemName: pokemon.isSaved ? "star.fill" : "star")
                //                .foregroundColor(.blue)
                //                .transition(AnyTransition.asymmetric(insertion: .scale, removal: .scale))
            }
            
        }
        //        }
        
    }
}













struct SearchRowView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
