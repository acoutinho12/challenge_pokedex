//
//  PokemonResult+Extension.swift
//  Pokedex
//
//  Created by André Luis Barbosa Coutinho on 06/10/22.
//

import Foundation

extension PokemonResult {
    func getPokemonID() -> String? {
        url.components(separatedBy: CharacterSet.decimalDigits.inverted).split(separator: "").last?.joined()
    }
}
