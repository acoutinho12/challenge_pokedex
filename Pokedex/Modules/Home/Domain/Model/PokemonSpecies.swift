//
//  PokemonSpecies.swift
//  Pokedex
//
//  Created by André Luis Barbosa Coutinho on 07/10/22.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let pokemonSpecies = try? newJSONDecoder().decode(PokemonSpecies.self, from: jsonData)

import Foundation

// MARK: - PokemonSpecies

struct PokemonSpecies: Codable {
    let evolutionChain: EvolutionChain?

    enum CodingKeys: String, CodingKey {
        case evolutionChain = "evolution_chain"
    }
}

// MARK: - EvolutionChain

struct EvolutionChain: Codable {
    let url: String?
}
