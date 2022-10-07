//
//  PokemonStatsView.swift
//  Pokedex
//
//  Created by André Luis Barbosa Coutinho on 07/10/22.
//

import UIKit

final class PokemonStatsView: UIView {
    private let titleLabel: UILabel = BodySolidLabel()
    private let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 8
        view.distribution = .equalSpacing
        view.alignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let maxBaseStat: Float = 200.0

    init() {
        super.init(frame: CGRect())
        titleLabel.text = "Base Stats"
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        addSubview(stackView)
        NSLayoutConstraint.topAnchor(view: stackView, superView: self, constant: 48)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setup(stat: Stat, color: UIColor) {
        let label: UILabel = SubTitleSolidLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = color
        label.text = stat.stat?.name?.uppercased()

        let statValue: UILabel = SubTitleSolidLabel()
        statValue.translatesAutoresizingMaskIntoConstraints = false
        statValue.textColor = color
        statValue.text = "\(stat.baseStat ?? 0)"

        let slider = UISlider()
        slider.value = Float(Float(stat.baseStat ?? 0) / maxBaseStat)
        slider.isEnabled = false
        slider.minimumTrackTintColor = color
        slider.isHighlighted = true
        slider.setThumbImage(UIImage(), for: .normal)
        let horizontalStackView: UIStackView = {
            let view = UIStackView()
            view.axis = .horizontal
            view.spacing = 8
            view.distribution = .fill
            view.alignment = .center
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false

        stackView.addArrangedSubview(horizontalStackView)
        horizontalStackView.addArrangedSubview(label)
        horizontalStackView.addArrangedSubview(statValue)
        horizontalStackView.addArrangedSubview(slider)

        NSLayoutConstraint.heightConstant(view: horizontalStackView, constant: 20)
        NSLayoutConstraint.leadingAnchor(view: horizontalStackView, superView: self, constant: 16)
        NSLayoutConstraint.trailingAnchor(view: horizontalStackView, superView: self, constant: -16)

        NSLayoutConstraint.heightConstant(view: label, constant: 16)
        NSLayoutConstraint.heightConstant(view: statValue, constant: 16)
    }

    func setTitle(color: UIColor, width: CGFloat) {
        titleLabel.textColor = color
        titleLabel.textAlignment = .center
        NSLayoutConstraint.widthConstant(view: titleLabel, constant: width)
        NSLayoutConstraint.heightConstant(view: titleLabel, constant: 60)
        NSLayoutConstraint.topAnchor(view: titleLabel, superView: self)
        NSLayoutConstraint.centerX(view: titleLabel, superView: self)
    }
}
