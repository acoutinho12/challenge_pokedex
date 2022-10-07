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
    func getPokemonAbilityDetails(id: String, completion: @escaping(Result<PokemonAbilityDetails, Error>) -> Void)
    func getPokemonEvolutionChain(id: String, completion: @escaping(Result<PokemonEvolutionChain, Error>) -> Void)
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

    func getPokemonAbilityDetails(id: String, completion: @escaping(Result<PokemonAbilityDetails, Error>) -> Void) {
        client.get(from: "ability/" + id, resultType: PokemonAbilityDetails.self) { result in
            completion(result)
        }
    }

    func getPokemonEvolutionChain(id: String, completion: @escaping(Result<PokemonEvolutionChain, Error>) -> Void) {
        getPokemonSpeciesId(id: id) { [weak self] result in
            switch result {
            case let .success(id):
                self?.client.get(from: "evolution-chain/" + id, resultType: PokemonEvolutionChain.self) { result in
                    completion(result)
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    private func getPokemonSpeciesId(id: String, completion: @escaping(Result<String, Error>) -> Void) {
        client.get(from: "pokemon-species/" + id, resultType: PokemonSpecies.self) { result in
            switch result {
            case let .success(pokemonSpecies):
                let id = pokemonSpecies.evolutionChain?.url?.components(separatedBy: CharacterSet.decimalDigits.inverted).split(separator: "").last?.joined()
                completion(.success(id ?? "1"))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
