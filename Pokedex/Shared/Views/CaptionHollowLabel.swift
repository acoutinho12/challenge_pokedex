//
//  CaptionHollowLabel.swift
//  Pokedex
//
//  Created by André Luis Barbosa Coutinho on 07/10/22.
//

import UIKit

class CaptionHollowLabel: UILabel {
    override func layoutSubviews() {
        font = UIFont(name: "Pokemon Hollow", size: 14)
    }
}
