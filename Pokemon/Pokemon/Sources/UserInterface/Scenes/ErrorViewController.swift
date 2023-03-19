//
//  ErrorViewController.swift
//  Pokemon
//
//  Created by Eduard Ani on 20.03.2023.
//

import Lottie
import UIKit

protocol ErrorViewControllerDelegate: AnyObject {
    func didTapRetry()
}

final class ErrorViewController: UIViewController {
    private unowned let delegate: ErrorViewControllerDelegate
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 24
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 48, left: 32, bottom: 48, right: 32)
        return stackView
    }()
    
    private lazy var animationView: LottieAnimationView = {
        let animationView = LottieAnimationView(name: "retry-animation")
        animationView.loopMode = .loop
        return animationView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Something went wrong..."
        label.textColor = .label
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "Please try again."
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    private lazy var retryButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.setTitle("RETRY", for: .normal)
        button.setTitleColor(.systemGreen, for: .normal)
        button.addTarget(self, action: #selector(retryButtonTouched), for: .touchUpInside)
        button.layer.borderColor = UIColor.systemGreen.cgColor
        button.layer.borderWidth = 1
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 4
        return button
    }()
    
    init(delegate: ErrorViewControllerDelegate) {
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = stackView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    private func initView() {
        stackView.addArrangedSubview(animationView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionLabel)
        
        let spacerView = UIView()
        stackView.addArrangedSubview(spacerView)
        
        stackView.addArrangedSubview(retryButton)
        
        stackView.setCustomSpacing(8, after: titleLabel)
        
        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: animationView.heightAnchor),
            
            retryButton.widthAnchor.constraint(equalTo: stackView.widthAnchor, constant: -64),
            retryButton.heightAnchor.constraint(equalToConstant: 48)
        ])
        
        animationView.play()
    }
    
    @objc private func retryButtonTouched() {
        delegate.didTapRetry()
    }
}
