//
//  Pokemon.swift
//  Pokedex
//
//  Created by André Luis Barbosa Coutinho on 05/10/22.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let pokemon = try? newJSONDecoder().decode(Pokemon.self, from: jsonData)

import Foundation

// MARK: - Pokemon

struct Pokemon: Decodable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [PokemonResult]
}

// MARK: - Result

struct PokemonResult: Codable {
    let name: String
    let url: String
}
