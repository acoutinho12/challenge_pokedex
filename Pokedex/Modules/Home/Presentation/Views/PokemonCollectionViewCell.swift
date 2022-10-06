//
//  PokemonCollectionViewCell.swift
//  Pokedex
//
//  Created by André Luis Barbosa Coutinho on 05/10/22.
//

import UIKit

class PokemonCollectionViewCell: UICollectionViewCell {
    static let forCellWithReuseIdentifier = "PokemonCollectionViewCell"
    var btnLabel = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setup(pokemon: PokemonResult) {
        backgroundColor = .lightGray
        addSubview(btnLabel)
        btnLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([btnLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor)])
        btnLabel.text = pokemon.name
    }
}
