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

    func getPokemons(next: String?, completion: @escaping(Result<Pokemon, Error>) -> Void) {
        datasource.getPokemons(next: next) { result in
            completion(result)
        }
    }

    func getPokemonDetails(id: String, completion: @escaping(Result<PokemonDetails, Error>) -> Void) {
        datasource.getPokemonDetails(id: id) { result in
            completion(result)
        }
    }
}
