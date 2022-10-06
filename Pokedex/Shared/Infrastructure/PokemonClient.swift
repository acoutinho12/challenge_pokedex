//
//  PokemonClient.swift
//  Pokedex
//
//  Created by André Luis Barbosa Coutinho on 05/10/22.
//

import Foundation

final class PokemonClient: HttpClient {
    static let shared = PokemonClient(baseURL: Urls.pokemonBaseURL)
}
