//
//  detailView.swift
//  Pokedex2.0
//
//  Created by sun on 2021/11/03.
//

import SwiftUI

struct detailView: View {
    @ObservedObject var viewModel: SearchViewModel
    @ObservedObject var pokemon: PokemonViewModel
    
    var body: some View {
            ZStack {
                RoundedRectangle(cornerRadius: 0)
                    .foregroundColor(.red)
                RoundedRectangle(cornerRadius: 30)
                    .foregroundColor(.white)
                //                .opacity(0.3)
                    .padding(.vertical, 40)
                    .padding(.horizontal, 20)
                RoundedRectangle(cornerRadius: 30)
                    .foregroundColor(.gray)
                    .opacity(0.5)
                    .padding(.vertical, 40)
                    .padding(.horizontal, 20)
                
                VStack {
                    ZStack {
                        Circle()
                        //                        .strokeBorder(lineWidth: 3)
                            .frame(width: 110, height: 110)
                            .foregroundColor(.white)
                            .opacity(0.4)
//                        NavigationLink(destination: Text("HI")) {
                        ProfileImageView(image: pokemon.profileImage)
//                        }
                    }
                    .frame(width: 110, height: 160)
                    VStack(alignment: .leading, spacing: 5) {
                        Text("No. \(String(pokemon.id))")
                        Text("")
                        Text("NAME : \(pokemon.name)")
                        Text("WEIGHT : \(String(pokemon.height))")
                        Text("HEIGHT : \(String(pokemon.weight))")
                        Text("TYPE: Rock, Ground")
                        Text("SKILL : rock-head, sturdy, sand-veil")
                        Text("EVOLUTION : Graveler")
                        Text("")
                        Text("Commonly found near mountain trails and the like. If you step on one by accident, it gets angry.")
                        //                Text(pokemon.id)
                        //                Text(pokemon.weight)
                        //                Text(pokemon.height)
                    }
                    .font(Font.custom("pixelmix", size: 15))
                    .padding(.horizontal, 90)
                }
                .position(x: 200, y: 290)
            }
            .navigationTitle("Geodude")
        }
}

//struct detailView_Previews: PreviewProvider {
//    static var previews: some View {
//        detailView()
//    }
//}
