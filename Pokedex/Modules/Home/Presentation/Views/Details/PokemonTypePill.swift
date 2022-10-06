//
//  PokemonTypePill.swift
//  Pokedex
//
//  Created by André Luis Barbosa Coutinho on 06/10/22.
//

import UIKit

class PokemonTypePill: UIView {
    private let type: UILabel = CaptionSolidLabel()
    override func layoutSubviews() {
        layer.cornerRadius = 12.0
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 30).isActive = true
    }

    func setup(species: Species) {
        addSubview(type)
        type.translatesAutoresizingMaskIntoConstraints = false
        type.heightAnchor.constraint(equalToConstant: 30).isActive = true
        type.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 35).isActive = true
        type.text = species.name?.capitalized
        type.textColor = .white
        backgroundColor = Colors.getColorBy(type: ColorsType(rawValue: species.name ?? "unknown") ?? .unknown)
    }
}
