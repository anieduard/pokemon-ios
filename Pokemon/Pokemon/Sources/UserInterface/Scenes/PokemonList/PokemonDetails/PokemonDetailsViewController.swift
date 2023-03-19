//
//  PokemonDetailsViewController.swift
//  Pokemon
//
//  Created by Eduard Ani on 18.03.2023.
//

import UIKit

final class PokemonDetailsViewController: UIViewController {
    
    private let viewModel: PokemonDetailsViewModelProtocol
    
    private lazy var tableView = UITableView()
    
    init(viewModel: PokemonDetailsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        title = "PokéApp"
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override func loadView() {
//        view = tableView
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        
        // Apply data source with loading cells.
//        dataSource.apply(viewModel.dataSourceSnapshot)
        
        // Refresh data with pokemon cells.
        Task {
            do {
//                tableView.isScrollEnabled = false
                try await viewModel.loadPokemonDetails()
//                tableView.isScrollEnabled = true
                
//                dataSource.apply(viewModel.dataSourceSnapshot, completion: nil)
            }
        }
    }
    
    private func initView() {
        
    }
}
