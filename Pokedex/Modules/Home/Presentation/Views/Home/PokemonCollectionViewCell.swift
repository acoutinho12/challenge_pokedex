//
//  PokemonCollectionViewCell.swift
//  Pokedex
//
//  Created by André Luis Barbosa Coutinho on 05/10/22.
//

import UIKit

class PokemonCollectionViewCell: UICollectionViewCell {
    static let forCellWithReuseIdentifier = "PokemonCollectionViewCell"
    private let name = BodySolidLabel()
    private var pokemonImage = UIImageView()
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func getPokemonId(pokemon: PokemonResult) -> String? {
        pokemon.getPokemonID()
    }

    func setup(pokemon: PokemonResult, tag: Int) {
        backgroundColor = Colors.secondaryBackgroundColor
        layer.cornerRadius = 5
        layer.borderWidth = 1
        layer.borderColor = Colors.secondaryBackgroundColor.cgColor
        let imageTag = tag + 99
        let id = getPokemonId(pokemon: pokemon)
        pokemonImage.tag = imageTag
        addSubview(name)
        addSubview(pokemonImage)
        configureConstraints()
        UIImageView.loadFrom(endPoint: "\(id ?? "0").png") { [weak self] pokemonImageView in
            guard let self = self, let view = self.viewWithTag(imageTag) as? UIImageView else {
                return
            }
            view.image = pokemonImageView?.image ?? UIImageView().image
        }
        name.text = pokemon.name.capitalized
    }

    private func configureConstraints() {
        let width = frame.width / 2
        name.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.centerX(view: name, superView: self)
        NSLayoutConstraint.yAxisAnchor(firstViewAnchor: name.topAnchor, superViewAnchor: pokemonImage.bottomAnchor)
        name.textColor = Colors.primaryColor

        pokemonImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.center(view: pokemonImage, superView: self)
        NSLayoutConstraint.widthHeightConstant(view: pokemonImage, constant: width)
    }
}
