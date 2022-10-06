//
//  PokemonDetailsHeader.swift
//  Pokedex
//
//  Created by André Luis Barbosa Coutinho on 06/10/22.
//

import UIKit

class PokemonDetailsHeader: UIView {
    private lazy var nameLabel: UILabel = TitleSolidLabel()
    private lazy var idLabel: UILabel = BodySolidLabel()

    override func layoutSubviews() {
        super.layoutSubviews()

        let yCoord = bounds.size.height - 30.0

        let point1 = CGPoint(x: 0.0, y: yCoord)
        let point2 = CGPoint(x: bounds.size.width, y: yCoord)

        let cp1 = CGPoint(x: point1.x, y: bounds.size.height)
        let cp2 = CGPoint(x: bounds.size.width, y: bounds.size.height)

        let myBez = UIBezierPath()

        myBez.move(to: CGPoint(x: 0.0, y: yCoord))

        myBez.addCurve(to: point2, controlPoint1: cp1, controlPoint2: cp2)

        myBez.addLine(to: CGPoint(x: bounds.size.width, y: 0.0))
        myBez.addLine(to: CGPoint.zero)

        myBez.close()

        let cAShapeLayer = CAShapeLayer()
        cAShapeLayer.path = myBez.cgPath
        layer.mask = cAShapeLayer
    }

    func setup(pokemonDetails: PokemonDetails) {
        nameLabel.text = pokemonDetails.name?.capitalized
        idLabel.text = "#" + "\(pokemonDetails.id ?? 1)".leftPad(length: 3, pad: "0")
        backgroundColor = Colors.getColorBy(type: ColorsType(rawValue: pokemonDetails.types?.first?.type?.name ?? "unknown") ?? .unknown)
        addSubViews()
        configureSubView()
    }

    private func addSubViews() {
        addSubview(nameLabel)
        addSubview(idLabel)
    }

    private func configureSubView() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.textColor = .white
        let topConstant: CGFloat = 64.0
        let horizontalPadding: CGFloat = 16.0
        NSLayoutConstraint.topAnchor(view: nameLabel, superView: self, isSafeArea: true, constant: topConstant)
        NSLayoutConstraint.leadingAnchor(view: nameLabel, superView: self, constant: horizontalPadding)

        idLabel.textColor = .white
        idLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.topAnchor(view: idLabel, superView: self, isSafeArea: true, constant: topConstant)
        NSLayoutConstraint.trailingAnchor(view: idLabel, superView: self, constant: -horizontalPadding)
    }
}
