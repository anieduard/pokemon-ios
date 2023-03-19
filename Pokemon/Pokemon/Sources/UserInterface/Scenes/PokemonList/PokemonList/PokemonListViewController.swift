//
//  PokemonListViewController.swift
//  Pokemon
//
//  Created by Eduard Ani on 18.03.2023.
//

import UIKit

final class PokemonListViewController: UIViewController {
    private let viewModel: PokemonListViewModelProtocol
    
    private lazy var tableView = UITableView()
    
    private lazy var dataSource: UITableViewDiffableDataSource<PokemonListViewModel.Section, PokemonListViewModel.Section.Item> = {
        let dataSource = UITableViewDiffableDataSource<PokemonListViewModel.Section, PokemonListViewModel.Section.Item>(tableView: tableView) { tableView, indexPath, item in
            switch item {
            case .loading:
                let cell: ShimmerTableViewCell = tableView.dequeueReusableCell(for: indexPath)
                return cell
            case .pokemon(let index, let pokemon):
                let cell: PokemonTableViewCell = tableView.dequeueReusableCell(for: indexPath)
                cell.index = index
                cell.name = pokemon.name
                return cell
            }
        }
        
        dataSource.defaultRowAnimation = .fade
        
        return dataSource
    }()
    
    init(viewModel: PokemonListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        title = "PokéApp"
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = tableView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        
        // Apply data source with loading cells.
        dataSource.apply(viewModel.dataSourceSnapshot)
        
        // Refresh data with pokemon cells.
        Task {
            do {
                tableView.isScrollEnabled = false
                try await viewModel.loadPokemons()
                tableView.isScrollEnabled = true
                
                dataSource.apply(viewModel.dataSourceSnapshot, completion: nil)
            }
        }
    }
    
    private func initView() {
        tableView.dataSource = dataSource
        tableView.delegate = self
        tableView.refreshControl = {
            let refreshControl = UIRefreshControl()
            refreshControl.addTarget(self, action: #selector(refreshControlValueChanged), for: .valueChanged)
            return refreshControl
        }()
        tableView.register(ShimmerTableViewCell.self)
        tableView.register(PokemonTableViewCell.self)
    }
    
    @objc private func refreshControlValueChanged() {
        Task {
            do {
                try await viewModel.loadPokemons()
                
                tableView.refreshControl?.endRefreshing()
                dataSource.apply(viewModel.dataSourceSnapshot, completion: nil)
            }
        }
    }
}

// MARK: - UITableViewDelegate

extension PokemonListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.didSelectItem(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.dataSourceSnapshot.numberOfItems - 1 {
            Task {
                do {
                    try await viewModel.loadMorePokemons()
                    
                    dataSource.apply(viewModel.dataSourceSnapshot, completion: nil)
                }
            }
        }
    }
}
