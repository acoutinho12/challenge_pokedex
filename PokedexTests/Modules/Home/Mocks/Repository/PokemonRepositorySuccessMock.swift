//
//  PokemonRepositorySuccessMock.swift
//  PokedexTests
//
//  Created by André Luis Barbosa Coutinho on 08/10/22.
//

@testable import Pokedex

final class PokemonRepositorySuccessMock: PokemonRepository {
    private let datasource: PokemonDataSource = PokemonDataSourceSuccessMock()

    var getPokemonsNumberOfCalls = 0
    var getPokemonDetailsNumberOfCalls = 0
    var getPokemonAbilityDetailsNumberOfCalls = 0
    var getPokemonEvolutionChainNumberOfCalls = 0

    func getPokemons(next: String?, completion: @escaping(Result<Pokemon, Error>) -> Void) {
        getPokemonsNumberOfCalls += 1
        datasource.getPokemons(next: next) { result in
            completion(result)
        }
    }

    func getPokemonDetails(id: String, completion: @escaping(Result<PokemonDetails, Error>) -> Void) {
        getPokemonDetailsNumberOfCalls += 1
        datasource.getPokemonDetails(id: id) { result in
            completion(result)
        }
    }

    func getPokemonAbilityDetails(id: String, completion: @escaping(Result<PokemonAbilityDetails, Error>) -> Void) {
        getPokemonAbilityDetailsNumberOfCalls += 1
        datasource.getPokemonAbilityDetails(id: id) { result in
            completion(result)
        }
    }

    func getPokemonEvolutionChain(id: String, completion: @escaping(Result<PokemonEvolutionChain, Error>) -> Void) {
        getPokemonEvolutionChainNumberOfCalls += 1
        datasource.getPokemonEvolutionChain(id: id) { result in
            completion(result)
        }
    }
}
