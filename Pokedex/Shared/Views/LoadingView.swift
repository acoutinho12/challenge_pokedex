//
//  LoadingView.swift
//  Pokedex
//
//  Created by André Luis Barbosa Coutinho on 05/10/22.
//

import UIKit

final class LoadingView: UIView {
    private let activityView = UIActivityIndicatorView(style: .whiteLarge)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func setup() {
        addSubview(activityView)
        activityView.hidesWhenStopped = true
        activityView.center = center
        activityView.startAnimating()
    }

    func stop() {
        activityView.stopAnimating()
    }
}
