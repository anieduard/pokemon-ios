//
//  PokemonDetailsViewModel.swift
//  Pokemon
//
//  Created by Eduard Ani on 18.03.2023.
//

import Foundation
import UIKit

@MainActor
protocol PokemonDetailsViewModelDelegate: AnyObject {
    func didFailLoadingPokemonDetails(with error: Error)
}

@MainActor
protocol PokemonDetailsViewModelProtocol: AnyObject {
    func loadPokemonDetails() async throws
}

final class PokemonDetailsViewModel: PokemonDetailsViewModelProtocol {
    private let pokemonsService: PokemonsServiceProtocol
    private unowned let delegate: PokemonDetailsViewModelDelegate
    
    init(pokemonsService: PokemonsServiceProtocol, delegate: PokemonDetailsViewModelDelegate) {
        self.pokemonsService = pokemonsService
        self.delegate = delegate
    }
    
    func loadPokemonDetails() async throws {
        do {
//            let details = try await pokemonsService.pokemons
            
            
        } catch {
            delegate.didFailLoadingPokemonDetails(with: error)
            throw error
        }
    }
}
