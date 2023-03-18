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
    private unowned let delegate: PokemonListViewModelDelegate
    
    init(delegate: PokemonListViewModelDelegate) {
        self.delegate = delegate
    }
}
