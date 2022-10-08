//
//  PokemonAbilityDetails.swift
//  Pokedex
//
//  Created by André Luis Barbosa Coutinho on 07/10/22.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let pokemonAbilityDetail = try? newJSONDecoder().decode(PokemonAbilityDetail.self, from: jsonData)

import Foundation

// MARK: - PokemonAbilityDetail

struct PokemonAbilityDetails: Codable {
    let effectEntries: [EffectEntry]?

    enum CodingKeys: String, CodingKey {
        case effectEntries = "effect_entries"
    }
}

// MARK: - EffectEntry

struct EffectEntry: Codable {
    let effect: String?
    let language: Language?
    let shortEffect: String?

    enum CodingKeys: String, CodingKey {
        case effect, language
        case shortEffect = "short_effect"
    }
}

// MARK: - Language

struct Language: Codable {
    let name: String?
    let url: String?
}
