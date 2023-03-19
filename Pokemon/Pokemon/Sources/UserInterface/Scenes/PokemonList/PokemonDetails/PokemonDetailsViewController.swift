//
//  PokemonDetailsViewController.swift
//  Pokemon
//
//  Created by Eduard Ani on 18.03.2023.
//

import UIKit

final class PokemonDetailsViewController: UIViewController {
    private let viewModel: PokemonDetailsViewModelProtocol
    
    init(viewModel: PokemonDetailsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    private func initView() {
        
    }
}
