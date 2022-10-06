//
//  PokemonDataSource.swift
//  Pokedex
//
//  Created by André Luis Barbosa Coutinho on 05/10/22.
//

import Foundation

protocol PokemonDataSource {
    func getPokemons(next: String?, completion: @escaping(Result<Pokemon, Error>) -> Void)
    func getPokemonDetails(id: String, completion: @escaping(Result<PokemonDetails, Error>) -> Void)
}

final class PokemonDataSourceImpl: PokemonDataSource {
    private let client: HttpClient = PokemonClient.shared

    func getPokemons(next: String?, completion: @escaping(Result<Pokemon, Error>) -> Void) {
        client.get(from: next ?? "pokemon", resultType: Pokemon.self) { result in
            completion(result)
        }
    }

    func getPokemonDetails(id: String, completion: @escaping(Result<PokemonDetails, Error>) -> Void) {
        client.get(from: "pokemon/" + id, resultType: PokemonDetails.self) { result in
            completion(result)
        }
    }
}
