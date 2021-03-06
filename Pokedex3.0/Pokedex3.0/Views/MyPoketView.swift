//
//  MyPoketView.swift
//  Pokedex3.0
//
//  Created by sun on 2021/10/29.
//

import SwiftUI
import CoreData

struct MyPoketView: View {
    @EnvironmentObject var viewModel: SearchViewModel
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(
        entity: PokemonEntity.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \PokemonEntity.name, ascending: true)]
    ) var pokemonEntity: FetchedResults<PokemonEntity>
    
    var body: some View {
        NavigationView {
            ZStack {
                if let myPokemons = viewModel.myPokemons {

                    List {
                        ForEach(pokemonEntity, id: \.self) { pokemon in
//                            let pokemonModel = Pokemon(name: pokemon.name, id: pokemon.pokeID, height: pokemon.height, weight: pokemon.weight)
                            var poke = PokemonViewModel(pokemon: Pokemon(name: pokemon.name!, id: Int(pokemon.pokeID), height: Int(pokemon.height), weight: Int(pokemon.weight)))
                            poke.isSaved = pokemon.isSaved
                            poke.profileImage = Image(systemName: "star")
                            SearchRowView(pokemon: poke)
                                .environmentObject(viewModel)
                                .padding(.vertical)
                        }
                        .onDelete(perform: deletePokemon(offsets:))
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
            .navigationBarTitle("My Pokét!")
        }
    }
    
    private func addPokemon() {
        withAnimation {
            let newItem = PokemonEntity(context: managedObjectContext)
            newItem.name = pokemon.name
            newItem.pokeID = Int32(pokemon.id)
            newItem.weight = Int32(pokemon.weight)
            newItem.height = Int32(pokemon.height)
            newItem.isSaved = true
//            newItem.profileImage = pokemon.profileImage!.jpegData()

            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    private func deletePokemon(offsets: IndexSet) {
        withAnimation {
            offsets.map { pokemonEntity[$0] }.forEach(managedObjectContext.delete)

            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}














struct MyPoketView_Previews: PreviewProvider {
    static var previews: some View {
        PokedexView()
    }
}
