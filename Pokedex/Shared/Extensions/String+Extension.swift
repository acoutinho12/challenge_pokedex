//
//  String+Extension.swift
//  Pokedex
//
//  Created by André Luis Barbosa Coutinho on 06/10/22.
//

import Foundation

extension String {
    func leftPad(length: Int, pad: String) -> String {
        String(String(reversed()).padding(toLength: length, withPad: pad, startingAt: 0).reversed())
    }
}
