//
//  PokemonRepositoryTests.swift
//  PokedexTests
//
//  Created by André Luis Barbosa Coutinho on 08/10/22.
//

import XCTest
@testable import Pokedex

class PokemonRepositoryTests: XCTestCase {
    var pokemonRepository: PokemonRepositoryImpl?
    var datasource: PokemonDataSourceSuccessMock?
    var helper: PokemonMockHelpers?
    override func setUp() {
        super.setUp()
        datasource = PokemonDataSourceSuccessMock()
        pokemonRepository = PokemonRepositoryImpl(datasource: datasource!)
        helper = PokemonMockHelpers()
    }

    override func tearDown() {
        datasource = nil
        pokemonRepository = nil
        helper = nil
        super.tearDown()
    }

    func test_success_get_pokemons() {
        pokemonRepository?.getPokemons(next: "") { [weak self] result in
            guard case let .success(value) = result else {
                return XCTFail("Expected to be a success but got a failure with \(result)")
            }
            XCTAssertEqual(value.count, self?.helper?.pokemonMock.count)
            XCTAssertEqual(value.next, self?.helper?.pokemonMock.next)
            XCTAssertEqual(value.previous, self?.helper?.pokemonMock.previous)
            XCTAssertEqual(value.previous, self?.helper?.pokemonMock.previous)
            XCTAssertEqual(value.results[0].name, self?.helper?.pokemonMock.results[0].name)
            XCTAssertEqual(value.results[0].url, self?.helper?.pokemonMock.results[0].url)
            XCTAssertEqual(self?.datasource?.getPokemonsNumberOfCalls, 1)
        }
    }

    func test_success_get_pokemon_ability_details() {
        pokemonRepository?.getPokemonAbilityDetails(id: "") { [weak self] result in
            guard case let .success = result else {
                return XCTFail("Expected to be a success but got a failure with \(result)")
            }
            XCTAssertEqual(self?.datasource?.getPokemonAbilityDetailsNumberOfCalls, 1)
        }
    }

    func test_success_get_pokemon_details() {
        pokemonRepository?.getPokemonDetails(id: "") { [weak self] result in
            guard case let .success(value) = result else {
                return XCTFail("Expected to be a success but got a failure with \(result)")
            }
            XCTAssertEqual(value.id, self?.helper?.pokemonDetails.id)
            XCTAssertEqual(value.name, self?.helper?.pokemonDetails.name)
            XCTAssertEqual(self?.datasource?.getPokemonDetailsNumberOfCalls, 1)
        }
    }

    func test_success_get_pokemon_evolution_chain() {
        pokemonRepository?.getPokemonEvolutionChain(id: "") { [weak self] result in
            guard case let .success(value) = result else {
                return XCTFail("Expected to be a success but got a failure with \(result)")
            }
            XCTAssertEqual(value.id, self?.helper?.pokemonEvolutionChain.id)
            XCTAssertEqual(value.chain?.isBaby, self?.helper?.pokemonEvolutionChain.chain?.isBaby)
            XCTAssertEqual(self?.datasource?.getPokemonEvolutionChainNumberOfCalls, 1)

        }
    }
}
