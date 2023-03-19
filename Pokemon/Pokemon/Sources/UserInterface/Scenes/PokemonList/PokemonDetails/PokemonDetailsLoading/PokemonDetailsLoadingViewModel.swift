//
//  PokemonDetailsLoadingViewModel.swift
//  Pokemon
//
//  Created by Eduard Ani on 20.03.2023.
//

import Foundation

@MainActor
protocol PokemonDetailsLoadingViewModelDelegate: AnyObject {
    func didLoadPokemonDetails(_ pokemonDetails: PokemonDetails)
    func didFailLoadingPokemonDetails(with error: Error)
}

@MainActor
protocol PokemonDetailsLoadingViewModelProtocol: AnyObject {
    func loadPokemonDetails()
}

final class PokemonDetailsLoadingViewModel: PokemonDetailsLoadingViewModelProtocol {
    private let pokemonService: PokemonsServiceProtocol
    private let pokemon: Pokemon
    private weak var delegate: PokemonDetailsLoadingViewModelDelegate?
    
    init(pokemonService: PokemonsServiceProtocol, pokemon: Pokemon, delegate: PokemonDetailsLoadingViewModelDelegate) {
        self.pokemonService = pokemonService
        self.pokemon = pokemon
        self.delegate = delegate
    }
    
    func loadPokemonDetails() {
        Task {
            do {
                let pokemonDetails = try await pokemonService.pokemonDetails(url: pokemon.url)
                delegate?.didLoadPokemonDetails(pokemonDetails)
            } catch {
                delegate?.didFailLoadingPokemonDetails(with: error)
            }
        }
    }
}
