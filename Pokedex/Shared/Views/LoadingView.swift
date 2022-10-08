//
//  LoadingView.swift
//  Pokedex
//
//  Created by André Luis Barbosa Coutinho on 05/10/22.
//

import UIKit

final class LoadingView: UIView {
    private let screenSize: CGRect = UIScreen.main.bounds
    private let spinner = UIActivityIndicatorView()
    private let loadingLabel = BodySolidLabel()

    init() {
        super.init(frame: CGRect())
        let width: CGFloat = 120
        let height: CGFloat = 30
        let xCoord = (screenSize.width / 2) - (width / 2)
        let yCoord = (screenSize.height / 2.5)
        frame = CGRect(x: xCoord, y: yCoord, width: width, height: height)

        loadingLabel.textColor = .black
        loadingLabel.textAlignment = .center
        loadingLabel.text = "Carregando..."
        loadingLabel.frame = CGRect(x: 20, y: 0, width: 140, height: 30)
        addSubview(spinner)
        addSubview(loadingLabel)

        if #available(iOS 13.0, *) {
            spinner.style = .large
        } else {
            spinner.style = .whiteLarge
        }

        spinner.color = .black
        spinner.frame = CGRect(x: -10, y: 0, width: 30, height: 30)
        spinner.startAnimating()
    }

    func stop() {
        spinner.stopAnimating()
        spinner.isHidden = true
        loadingLabel.isHidden = true
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
