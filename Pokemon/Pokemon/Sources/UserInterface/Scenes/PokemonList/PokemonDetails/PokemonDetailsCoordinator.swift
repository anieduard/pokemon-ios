//
//  PokemonDetailsCoordinator.swift
//  Pokemon
//
//  Created by Eduard Ani on 19.03.2023.
//

import UIKit

final class PokemonDetailsCoordinator: UIViewController {
    private enum State {
        case loading
        case content(PokemonDetails)
        case error(Error)
    }
    
    private let pokemonsService: PokemonsServiceProtocol
    private let pokemon: Pokemon
    
    private var state: State? {
        didSet {
            switch (oldValue, state) {
            case (.none, .loading), (.error, .loading):
                let viewModel = PokemonDetailsLoadingViewModel(pokemonService: pokemonsService, pokemon: pokemon, delegate: self)
                rootViewController = PokemonDetailsLoadingViewController(viewModel: viewModel)
            case (.loading, .content(let pokemonDetails)):
                let viewModel = PokemonDetailsViewModel(pokemonDetails: pokemonDetails)
                rootViewController = PokemonDetailsViewController(viewModel: viewModel)
            case (.loading, .error):
                rootViewController = UIViewController()
            default:
                fatalError("Unexpected state change, oldValue: \(String(describing: oldValue)), newValue: \(String(describing: state))")
            }
        }
    }
    
    private var rootViewController: UIViewController! {
        didSet {
            oldValue?.remove()
            add(rootViewController)
        }
    }
    
    init(pokemonsService: PokemonsServiceProtocol, pokemon: Pokemon) {
        self.pokemonsService = pokemonsService
        self.pokemon = pokemon
        super.init(nibName: nil, bundle: nil)
        
        title = "PokéApp"
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        state = .loading
    }
}

// MARK: - PokemonDetailsLoadingViewModelDelegate

extension PokemonDetailsCoordinator: PokemonDetailsLoadingViewModelDelegate {
    func didLoadPokemonDetails(_ pokemonDetails: PokemonDetails) {
        state = .content(pokemonDetails)
    }
    
    func didFailLoadingPokemonDetails(with error: Error) {
        state = .error(error)
    }
}
