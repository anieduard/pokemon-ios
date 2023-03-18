//
//  PokemonListCoordinator.swift
//  Pokemon
//
//  Created by Eduard Ani on 18.03.2023.
//

import UIKit

final class PokemonListCoordinator: UIViewController {
    
    private lazy var rootViewController: UIViewController = {
        let viewModel = PokemonListViewModel(delegate: self)
        let viewController = PokemonListViewController(viewModel: viewModel)
        return viewController
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        add(rootViewController)
    }
}

extension PokemonListCoordinator: PokemonListViewModelDelegate {
    
}
