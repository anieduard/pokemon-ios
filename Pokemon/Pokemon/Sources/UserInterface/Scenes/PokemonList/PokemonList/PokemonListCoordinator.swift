//
//  PokemonListCoordinator.swift
//  Pokemon
//
//  Created by Eduard Ani on 18.03.2023.
//

import UIKit

final class PokemonListCoordinator: UIViewController {
    private enum State {
        case content
        case error(Error)
    }
    
    private let pokemonsService: PokemonsServiceProtocol
    
    private var state: State? {
        didSet {
            let rootViewController: UIViewController
            
            switch (oldValue, state) {
            case (.none, .content), (.error, .content):
                let viewModel = PokemonListViewModel(pokemonsService: pokemonsService, delegate: self)
                rootViewController = PokemonListViewController(viewModel: viewModel)
            case (.content, .error):
                rootViewController = ErrorViewController(delegate: self)
            default:
                fatalError("Unexpected state change, oldValue: \(String(describing: oldValue)), newValue: \(String(describing: state))")
            }
            
            let navigationController = UINavigationController(rootViewController: rootViewController)
            self.rootViewController = navigationController
        }
    }
    
    private var rootViewController: UIViewController! {
        didSet {
            oldValue?.remove()
            add(rootViewController)
        }
    }
    
    override var navigationController: UINavigationController? { rootViewController as? UINavigationController }
    
    init(pokemonsService: PokemonsServiceProtocol) {
        self.pokemonsService = pokemonsService
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
        
        state = .content
    }
}

// MARK: - PokemonListViewModelDelegate

extension PokemonListCoordinator: PokemonListViewModelDelegate {
    func shouldShowDetails(for pokemon: Pokemon) {
        let coordinator = PokemonDetailsCoordinator(pokemonsService: pokemonsService, pokemon: pokemon)
        navigationController?.pushViewController(coordinator, animated: true)
    }
    
    func didFailLoadingPokemons(with error: Error) {
        state = .error(error)
    }
}

// MARK: - ErrorViewControllerDelegate

extension PokemonListCoordinator: ErrorViewControllerDelegate {
    func didTapRetry() {
        state = .content
    }
}
