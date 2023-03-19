//
//  PokemonDetailsViewModel.swift
//  Pokemon
//
//  Created by Eduard Ani on 18.03.2023.
//

import Foundation
import UIKit

@MainActor
protocol PokemonDetailsViewModelProtocol: AnyObject {
    
}

final class PokemonDetailsViewModel: PokemonDetailsViewModelProtocol {
    private let pokemonDetails: PokemonDetails
    
    init(pokemonDetails: PokemonDetails) {
        self.pokemonDetails = pokemonDetails
    }
}
