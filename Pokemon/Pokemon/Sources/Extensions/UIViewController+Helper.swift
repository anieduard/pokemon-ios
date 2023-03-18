//
//  UIViewController+Helper.swift
//  Pokemon
//
//  Created by Eduard Ani on 18.03.2023.
//

import UIKit

extension UIViewController {
    func add(_ child: UIViewController) {
        addChild(child)
        child.view.frame = view.frame
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }

    func remove() {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}
