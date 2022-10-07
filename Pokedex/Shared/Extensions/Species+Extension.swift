//
//  Species+Extension.swift
//  Pokedex
//
//  Created by André Luis Barbosa Coutinho on 07/10/22.
//

import Foundation

extension Species {
    func getURLID() -> String? {
        url?.components(separatedBy: CharacterSet.decimalDigits.inverted).split(separator: "").last?.joined()
    }
}
