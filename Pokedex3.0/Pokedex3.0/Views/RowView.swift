//
//  SearchRowView.swift
//  Pokedex3.0
//
//  Created by sun on 2021/10/29.
//

import SwiftUI
import CoreData

struct RowView: View {
    @EnvironmentObject var viewModel: SearchViewModel
//    @ObservedObject var pokemon: PokemonViewModel
    static var poke: Pokemon
    @ObservedObject var pokemon = PokemonViewModel(pokemon: poke)
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(
        entity: PokemonEntity.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \PokemonEntity.name, ascending: true)]
    ) var pokemonEntity: FetchedResults<PokemonEntity>
    
    var body: some View {
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
                        saveButton
                    }
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
    }
    
    var saveButton: some View {
        Button {
//            viewModel.toggleSaveStatus(of: pokemon)
//            let pokemonEntity = pokemonEntity(context: managedObjectContext)
//            pokemonEntity.name = pokemon.name
//            pokemonEntity.
            addPokemon()
        } label: {
            Image(systemName: pokemon.isSaved ? "star.fill" : "star")
                .foregroundColor(.blue)
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













struct SearchRowView_Previews: PreviewProvider {
    static var previews: some View {
        PokedexView()
    }
}

