//
//  PokemonEvolutionChainView.swift
//  Pokedex
//
//  Created by André Luis Barbosa Coutinho on 07/10/22.
//

import UIKit

final class PokemonEvolutionChainView: UIView {
    private let evolutionChainLabel = BodySolidLabel()
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private let horizontalStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 8
        view.distribution = .fillEqually
        view.alignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    func setup(evolutionChain: PokemonEvolutionChain, color: UIColor) {
        let species: [Species] = evolutionChain.chain?.getAllSpecies() ?? []
        let width = 250
        evolutionChainLabel.text = "Evolution Chain"
        evolutionChainLabel.textColor = color
        evolutionChainLabel.textAlignment = .center
        evolutionChainLabel.translatesAutoresizingMaskIntoConstraints = false
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(evolutionChainLabel)
        addSubview(scrollView)
        scrollView.addSubview(horizontalStackView)
        scrollView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: evolutionChainLabel.bottomAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        NSLayoutConstraint.leadingAnchor(view: horizontalStackView, superView: scrollView)
        NSLayoutConstraint.trailingAnchor(view: horizontalStackView, superView: scrollView)
        NSLayoutConstraint.topAnchor(view: horizontalStackView, superView: scrollView)
        NSLayoutConstraint.bottomAnchor(view: horizontalStackView, superView: scrollView)
        NSLayoutConstraint.heightAnchor(view: horizontalStackView, superView: scrollView)
        NSLayoutConstraint.widthConstant(view: horizontalStackView, constant: CGFloat(width * species.count))

        NSLayoutConstraint.topAnchor(view: evolutionChainLabel, superView: self, constant: 16)
        NSLayoutConstraint.heightConstant(view: evolutionChainLabel, constant: 30)

        NSLayoutConstraint.centerX(view: evolutionChainLabel, superView: self)

        species.forEach {
            let uiView = UIView()
            uiView.translatesAutoresizingMaskIntoConstraints = false
            let name = CaptionSolidLabel()
            name.translatesAutoresizingMaskIntoConstraints = false
            let pokemonImage = UIImageView()
            pokemonImage.translatesAutoresizingMaskIntoConstraints = false
            let id = $0.getURLID()
            let imageTag = ((id ?? "1") as NSString).integerValue
            pokemonImage.tag = imageTag
            uiView.addSubview(name)
            uiView.addSubview(pokemonImage)
            horizontalStackView.addArrangedSubview(uiView)
            UIImageView.loadFrom(endPoint: "\(id ?? "0").png") { [weak self] pokemonImageView in
                guard let self = self, let view = self.viewWithTag(imageTag) as? UIImageView else {
                    return
                }
                view.image = pokemonImageView?.image ?? UIImageView().image
            }

//            NSLayoutConstraint.heightConstant(view: uiView, constant: 210)
//            NSLayoutConstraint.widthConstant(view: uiView, constant: 300)
            NSLayoutConstraint.topAnchor(view: uiView, superView: horizontalStackView, constant: 16)

            NSLayoutConstraint.heightConstant(view: pokemonImage, constant: 200)
            NSLayoutConstraint.leadingAnchor(view: pokemonImage, superView: uiView)
            NSLayoutConstraint.trailingAnchor(view: pokemonImage, superView: uiView)
            NSLayoutConstraint.centerY(view: pokemonImage, superView: uiView)

            NSLayoutConstraint.heightConstant(view: name, constant: 20)
            NSLayoutConstraint.leadingAnchor(view: name, superView: uiView)
            NSLayoutConstraint.trailingAnchor(view: name, superView: uiView)
            NSLayoutConstraint.yAxisAnchor(firstViewAnchor: name.topAnchor, superViewAnchor: pokemonImage.bottomAnchor)
            name.text = $0.name
            name.textColor = color
            name.textAlignment = .center
        }
    }
}
