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
    var name: String { get }
    var image: URL { get }
    var types: [String] { get }
}

final class PokemonDetailsViewModel: PokemonDetailsViewModelProtocol {
    let name: String
    let image: URL
    let types: [String]
    
    init(pokemonDetails: PokemonDetails) {
        name = pokemonDetails.name.capitalized
        image = pokemonDetails.sprites.frontDefault
        types = pokemonDetails.types.map { $0.type.name }
    }
}
