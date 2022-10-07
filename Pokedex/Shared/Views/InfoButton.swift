//
//  InfoButton.swift
//  Pokedex
//
//  Created by André Luis Barbosa Coutinho on 07/10/22.
//

import UIKit

final class InfoButton: UIButton {
    private var action: (() -> Void)?
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
        let image = UIButton(type: .infoLight).currentImage
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = image
        NSLayoutConstraint.heightConstant(view: imageView, constant: 15)
        NSLayoutConstraint.widthConstant(view: imageView, constant: 15)
        addSubview(imageView)
        setTitle("", for: .normal)
        titleLabel?.font = UIFont(name: "Pokemon Hollow", size: 14)
        setTitleColor(.systemBlue, for: .normal)
        NSLayoutConstraint.centerY(view: imageView, superView: self)
        NSLayoutConstraint.centerY(view: titleLabel ?? self, superView: self)
        NSLayoutConstraint.xAxisAnchor(firstViewAnchor: imageView.trailingAnchor, superViewAnchor: titleLabel?.leadingAnchor ?? leadingAnchor, constant: -4)
    }

    func setAction(action: (() -> Void)?) {
        self.action = action
        addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    @objc
    func buttonAction(sender _: UIButton!) {
        action?()
    }
}
