//
//  PokemonTypePillView.swift
//  Pokedex
//
//  Created by André Luis Barbosa Coutinho on 06/10/22.
//

import UIKit

class PokemonTypePillView: UIView {
    private let type: UILabel = CaptionSolidLabel()
    override func layoutSubviews() {
        layer.cornerRadius = 12.0
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 30).isActive = true
    }

    func setup(species: Species, width: CGFloat, backGroundColor: UIColor? = nil) {
        addSubview(type)
        type.translatesAutoresizingMaskIntoConstraints = false
        type.heightAnchor.constraint(equalToConstant: 30).isActive = true
        type.widthAnchor.constraint(equalToConstant: width).isActive = true
        type.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        type.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        type.textAlignment = .center
        type.text = species.name?.capitalized
        type.textColor = .white
        backgroundColor = backGroundColor ?? Colors.getColorBy(type: ColorsType(rawValue: species.name ?? "unknown") ?? .unknown)
    }
}
