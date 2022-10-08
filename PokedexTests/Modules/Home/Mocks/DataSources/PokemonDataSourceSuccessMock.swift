//
//  PokemonDataSourceSuccessMock.swift
//  PokedexTests
//
//  Created by André Luis Barbosa Coutinho on 08/10/22.
//

import Foundation
@testable import Pokedex

final class PokemonDataSourceSuccessMock: PokemonDataSource {
    private let helper = PokemonMockHelpers()
    private let pokemonMock: Pokemon
    private let pokemonDetails: PokemonDetails
    private let pokemonAbilityDetails: PokemonAbilityDetails
    private let pokemonEvolutionChain: PokemonEvolutionChain

    var getPokemonsNumberOfCalls = 0
    var getPokemonDetailsNumberOfCalls = 0
    var getPokemonAbilityDetailsNumberOfCalls = 0
    var getPokemonEvolutionChainNumberOfCalls = 0

    init() {
        pokemonMock = helper.pokemonMock
        pokemonDetails = helper.pokemonDetails
        pokemonAbilityDetails = helper.pokemonAbilityDetails
        pokemonEvolutionChain = helper.pokemonEvolutionChain
    }

    func getPokemons(next _: String?, completion: @escaping (Result<Pokemon, Error>) -> Void) {
        getPokemonsNumberOfCalls += 1
        completion(.success(pokemonMock))
    }

    func getPokemonDetails(id _: String, completion: @escaping (Result<PokemonDetails, Error>) -> Void) {
        getPokemonDetailsNumberOfCalls += 1
        completion(.success(pokemonDetails))
    }

    func getPokemonAbilityDetails(id _: String, completion: @escaping (Result<PokemonAbilityDetails, Error>) -> Void) {
        getPokemonAbilityDetailsNumberOfCalls += 1
        completion(.success(pokemonAbilityDetails))
    }

    func getPokemonEvolutionChain(id _: String, completion: @escaping (Result<PokemonEvolutionChain, Error>) -> Void) {
        getPokemonEvolutionChainNumberOfCalls += 1
        completion(.success(pokemonEvolutionChain))
    }

}
