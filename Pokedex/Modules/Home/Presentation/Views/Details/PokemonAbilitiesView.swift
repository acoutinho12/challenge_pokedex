//
//  PokemonAbilitiesView.swift
//  Pokedex
//
//  Created by André Luis Barbosa Coutinho on 07/10/22.
//

import UIKit

final class PokemonAbilitiesView: UIView {
    private let abilitiesLabel = BodySolidLabel()
    private var coordinator: HomeCoordinator?

    init(coordinator: HomeCoordinator?) {
        super.init(frame: CGRect())
        self.coordinator = coordinator
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private let horizontalStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 8
        view.distribution = .fillEqually
        view.alignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    func setup(abilities: [Ability], color: UIColor) {
        abilitiesLabel.text = "Abilities"
        abilitiesLabel.textColor = color
        abilitiesLabel.textAlignment = .center
        abilitiesLabel.translatesAutoresizingMaskIntoConstraints = false
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(abilitiesLabel)
        addSubview(horizontalStackView)
        NSLayoutConstraint.topAnchor(view: abilitiesLabel, superView: self, constant: 16)
        NSLayoutConstraint.heightConstant(view: abilitiesLabel, constant: 40)

        NSLayoutConstraint.heightConstant(view: horizontalStackView, constant: 40)
        NSLayoutConstraint.widthConstant(view: horizontalStackView, constant: frame.width * 0.9)
        NSLayoutConstraint.yAxisAnchor(firstViewAnchor: horizontalStackView.topAnchor, superViewAnchor: abilitiesLabel.bottomAnchor, constant: 8.0)
        NSLayoutConstraint.centerX(view: abilitiesLabel, superView: self)
        NSLayoutConstraint.centerX(view: horizontalStackView, superView: self)

        let abilitiesCount = abilities.count
        if abilitiesCount <= 0 {
            return
        }
        abilities.forEach {
            guard let species = $0.ability else {
                return
            }
            let abilityButton = InfoButton()
            abilityButton.setTitle(species.name?.capitalized, for: .normal)
            let id = species.getURLID() ?? "1"
            let action: (() -> Void)? = { [weak self] in self?.coordinator?.showAbilityInfoModal(id: id) }
            abilityButton.setAction(action: action)
            abilityButton.translatesAutoresizingMaskIntoConstraints = false
            horizontalStackView.addArrangedSubview(abilityButton)
        }
    }
}
