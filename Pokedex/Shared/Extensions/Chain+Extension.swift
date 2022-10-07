//
//  Chain+Extension.swift
//  Pokedex
//
//  Created by André Luis Barbosa Coutinho on 07/10/22.
//

import Foundation

extension Chain {
    func getAllSpecies() -> [Species] {
        var species: [Species] = []
        if let specie = self.species {
            species.append(contentsOf: [specie])
        }
        evolvesTo?.forEach {
            let recursiveSpecies = $0.getAllSpecies()
            if !recursiveSpecies.isEmpty {
                species.append(contentsOf: recursiveSpecies)
            }
        }
        return species
    }
}
