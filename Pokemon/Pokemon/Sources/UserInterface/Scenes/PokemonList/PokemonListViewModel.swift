//
//  PokemonListViewModel.swift
//  Pokemon
//
//  Created by Eduard Ani on 18.03.2023.
//

import Foundation

protocol PokemonListViewModelDelegate: AnyObject {
    
}

protocol PokemonListViewModelProtocol: AnyObject {
    
}

final class PokemonListViewModel: PokemonListViewModelProtocol {
    private let pokemonsService: PokemonsServiceProtocol
    private unowned let delegate: PokemonListViewModelDelegate
    
    init(pokemonsService: PokemonsServiceProtocol, delegate: PokemonListViewModelDelegate) {
        self.pokemonsService = pokemonsService
        self.delegate = delegate
    }
    
    func loadData() {
        Task {
            do {
                let pokemons = try await pokemonsService.pokemons
                print(pokemons)
            } catch {
                print(error)
            }
        }
    }
}
