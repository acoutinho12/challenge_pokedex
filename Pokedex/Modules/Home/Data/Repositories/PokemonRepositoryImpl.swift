//
//  PokemonRepositoryImpl.swift
//  Pokedex
//
//  Created by André Luis Barbosa Coutinho on 05/10/22.
//

import Foundation

final class PokemonRepositoryImpl: PokemonRepository {
    private let datasource: PokemonDataSource

    init(datasource: PokemonDataSource) {
        self.datasource = datasource
    }

    func getPokemons(completion: @escaping(Result<Pokemon, Error>) -> Void) {
        datasource.getPokemons { result in
            completion(result)
        }
    }
}
