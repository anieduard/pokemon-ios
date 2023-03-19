//
//  PokemonListViewModel.swift
//  Pokemon
//
//  Created by Eduard Ani on 18.03.2023.
//

import Foundation
import UIKit

@MainActor
protocol PokemonListViewModelDelegate: AnyObject {
    func shouldShowDetails(for pokemon: Pokemon)
    func didFailLoadingPokemons(with error: Error)
}

@MainActor
protocol PokemonListViewModelProtocol: AnyObject {
    var dataSourceSnapshot: PokemonListViewModel.DataSourceSnapshot { get }
    
    func loadPokemons() async throws
    func didSelectItem(at indexPath: IndexPath)
}

final class PokemonListViewModel: PokemonListViewModelProtocol {
    typealias DataSourceSnapshot = NSDiffableDataSourceSnapshot<Section, Section.Item>
    
    enum Section: Hashable {
        enum Item: Hashable {
            case loading(Int)
            case pokemon(Int, Pokemon)
        }
        
        case loading
        case pokemons
    }
    
    private(set) var dataSourceSnapshot: DataSourceSnapshot
    
    private let pokemonsService: PokemonsServiceProtocol
    private unowned let delegate: PokemonListViewModelDelegate
    private var pokemons: [Pokemon] = []
    
    init(pokemonsService: PokemonsServiceProtocol, delegate: PokemonListViewModelDelegate) {
        self.pokemonsService = pokemonsService
        self.delegate = delegate
        
        dataSourceSnapshot = DataSourceSnapshot()
        dataSourceSnapshot.appendSections([.loading])
        dataSourceSnapshot.appendItems((0..<15).map { .loading($0) }, toSection: .loading)
    }
    
    func loadPokemons() async throws {
        do {
            pokemons = try await pokemonsService.pokemons
            
            dataSourceSnapshot.deleteSections([.loading])
            dataSourceSnapshot.deleteSections([.pokemons])
            dataSourceSnapshot.appendSections([.pokemons])
            dataSourceSnapshot.appendItems(pokemons.enumerated().map { .pokemon($0 + 1, $1) }, toSection: .pokemons)
        } catch {
            delegate.didFailLoadingPokemons(with: error)
            throw error
        }
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        let pokemon = pokemons[indexPath.row]
        delegate.shouldShowDetails(for: pokemon)
    }
}
