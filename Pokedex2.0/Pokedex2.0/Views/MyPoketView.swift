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
            if #available(iOS 15.0, *) {
                VStack {
                    if let myPokemons = viewModel.myPokemons {
                        //                    ScrollView(.vertical, showsIndicators: false) {
                        List {
                            ForEach(myPokemons) { pokemon in
//                                NavigationLink(destination: detailView(viewModel: viewModel, pokemon: pokemon)) {
                                    SearchRowView(pokemon: pokemon)
                                        .environmentObject(viewModel)
                                        .padding(.vertical)
//                                0re
                            }
                            .onDelete { index in
                                withAnimation {
                                    viewModel.deleteInPoket(at: index)
                                }
                            }
                        }
                        .listStyle(.plain)
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
                .transition(.asymmetric(insertion: .identity, removal: .opacity))
                .navigationBarTitle("My Pokét!")
            } else {
                // Fallback on earlier versions
            }
        }
    }
}














struct MyPoketView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
