//
//  PokemonDetailsLoadingViewController.swift
//  Pokemon
//
//  Created by Eduard Ani on 19.03.2023.
//

import UIKit

final class PokemonDetailsLoadingViewController: UIViewController {
    private let viewModel: PokemonDetailsLoadingViewModelProtocol
    
    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView(style: .medium)
        return activityIndicatorView
    }()
    
    init(viewModel: PokemonDetailsLoadingViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = activityIndicatorView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.loadPokemonDetails()
        
        initView()
    }
    
    private func initView() {
        activityIndicatorView.startAnimating()
    }
}
