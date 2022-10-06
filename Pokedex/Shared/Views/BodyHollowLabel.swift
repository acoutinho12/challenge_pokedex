//
//  BodyHollowLabel.swift
//  Pokedex
//
//  Created by André Luis Barbosa Coutinho on 06/10/22.
//

import UIKit

class BodyHollowLabel: UILabel {
    init() {
        super.init(frame: CGRect())
        font = UIFont(name: "Pokemon Hollow", size: 20)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
