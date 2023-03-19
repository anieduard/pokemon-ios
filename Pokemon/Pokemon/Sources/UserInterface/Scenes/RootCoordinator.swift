//
//  RootCoordinator.swift
//  Pokemon
//
//  Created by Eduard Ani on 18.03.2023.
//

import UIKit

final class RootCoordinator: UIViewController {
    private let serviceCollection: ServiceCollection
    
    init() {
        let networkClient = NetworkClient()
        serviceCollection = ServiceCollection(networkClient: networkClient)
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pokemonsService = serviceCollection.resolve(type: PokemonsService.self)
        let pokemonListCoordinator = PokemonListCoordinator(pokemonsService: pokemonsService)
        add(pokemonListCoordinator)
    }
}
