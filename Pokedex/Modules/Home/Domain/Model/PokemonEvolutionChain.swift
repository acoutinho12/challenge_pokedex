//
//  PokemonEvolutionChain.swift
//  Pokedex
//
//  Created by André Luis Barbosa Coutinho on 07/10/22.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let pokemonEvolutionChain = try? newJSONDecoder().decode(PokemonEvolutionChain.self, from: jsonData)

import Foundation

// MARK: - PokemonEvolutionChain

struct PokemonEvolutionChain: Codable {
    let chain: Chain?
    let id: Int?

    enum CodingKeys: String, CodingKey {
        case chain, id
    }
}

// MARK: - Chain

struct Chain: Codable {
    let evolutionDetails: [EvolutionDetail]?
    let evolvesTo: [Chain]?
    let isBaby: Bool?
    let species: Species?

    enum CodingKeys: String, CodingKey {
        case evolutionDetails = "evolution_details"
        case evolvesTo = "evolves_to"
        case isBaby = "is_baby"
        case species
    }
}

// MARK: - EvolutionDetail

struct EvolutionDetail: Codable {
    let minLevel: Int?
    let needsOverworldRain: Bool?
    let timeOfDay: String?
    let trigger: Species?
    let turnUpsideDown: Bool?

    enum CodingKeys: String, CodingKey {
        case minLevel = "min_level"
        case needsOverworldRain = "needs_overworld_rain"
        case timeOfDay = "time_of_day"
        case trigger
        case turnUpsideDown = "turn_upside_down"
    }
}
