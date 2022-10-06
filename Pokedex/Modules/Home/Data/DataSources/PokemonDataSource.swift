//
//  PokemonDataSource.swift
//  Pokedex
//
//  Created by André Luis Barbosa Coutinho on 05/10/22.
//

import Foundation

protocol PokemonDataSource {
    func getPokemons(completion: @escaping(Result<Pokemon, Error>) -> Void)
}

final class PokemonDataSourceImpl: PokemonDataSource {
    private let client: HttpClient = PokemonClient.shared

    func getPokemons(completion: @escaping(Result<Pokemon, Error>) -> Void) {
        client.get(from: "pokemon", resultType: Pokemon.self) { result in
            completion(result)
        }
    }
}
