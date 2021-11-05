//
//  SearchView.swift
//  Pokedex2.0
//
//  Created by sun on 2021/10/29.
//

import SwiftUI

struct SearchView: View {
    //    @StateObject var viewModel = SearchViewModel()
    @EnvironmentObject var viewModel: SearchViewModel
    
    var body: some View {
        NavigationView {
            //            ScrollView(.vertical, showsIndicators: false) {
            VStack {
                List {
                    SearchBarView()
                        .padding()
                        .environmentObject(viewModel)
                    if viewModel.searchQuery.isEmpty {
                        //                        VStack(alignment: .center) {
                        HStack {
                            Spacer()
                            Text("Look for a pokemon")
                                .foregroundColor(.gray)
                                .padding(.vertical)
                            //                            .alignmentGuide(.center) { d in d[.leading] }
                            //                        }
                            Spacer()
                        }
                        
                    } else {
                        switch viewModel.loadingStatus {
                        case .loading:
                            HStack {
                                Spacer()
                            ProgressView()
                                Spacer()
                            }
                        case .loadingSuccess:
                            ForEach(viewModel.pokemons) { pokemon in
//                                withAnimation {
//                                NavigationLink(destination: detailView(viewModel: viewModel, pokemon: pokemon)) {
                                SearchRowView(pokemon: pokemon)
//                                }
//                                }
                            }
                        case .loadingFailure:
                            HStack {
                                Spacer()
                            Text("That's not a Pokemon Name...")
                                .foregroundColor(.gray)
                                .padding(.vertical)
                                Spacer()
                            }
                        }
                        
                        
                        //                    } else if viewModel.loadingStatus == .loading {
                        //                        ProgressView()
                        //                    } else if viewModel.pokemons.isEmpty {
                        //                        Text("That's not a Pokemon Name...")
                        //                            .padding(.top)
                        //                    } else {
                        //                    // change the SearchViewModel to implement ProgressView
                        //                    ForEach(viewModel.pokemons) { pokemon in
                        //                        //                    withAnimation {
                        //                        SearchRowView(pokemon: pokemon)
                        //                            .environmentObject(viewModel)
                        //                        //                    }
                        //                        }
                        //                        .transition(.scale)
                    }
                }
                .transition(.opacity)
                .listStyle(.inset)
            }
            .navigationBarTitle("Find A Pokémon!")
        }
    }
}





struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
