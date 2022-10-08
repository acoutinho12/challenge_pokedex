//
//  GetPokemonsUseCaseTests.swift
//  PokedexTests
//
//  Created by André Luis Barbosa Coutinho on 08/10/22.
//

import XCTest
@testable import Pokedex

class GetPokemonsUseCaseTests: XCTestCase {
    var getPokemonsUseCase: GetPokemonsUseCase?
    var repository: PokemonRepositorySuccessMock?
    var helper: PokemonMockHelpers?
    override func setUp() {
        super.setUp()
        repository = PokemonRepositorySuccessMock()
        getPokemonsUseCase = GetPokemonsUseCase(repository: repository!)
        helper = PokemonMockHelpers()
    }

    override func tearDown() {
        getPokemonsUseCase = nil
        repository = nil
        helper = nil
        super.tearDown()
    }

    func test_success_get_pokemons() {
        getPokemonsUseCase?.execute { [weak self] result in
            guard case let .success(value) = result else {
                return XCTFail("Expected to be a success but got a failure with \(result)")
            }
            XCTAssertEqual(value.count, self?.helper?.pokemonMock.count)
            XCTAssertEqual(value.next, self?.helper?.pokemonMock.next)
            XCTAssertEqual(value.previous, self?.helper?.pokemonMock.previous)
            XCTAssertEqual(value.previous, self?.helper?.pokemonMock.previous)
            XCTAssertEqual(value.results[0].name, self?.helper?.pokemonMock.results[0].name)
            XCTAssertEqual(value.results[0].url, self?.helper?.pokemonMock.results[0].url)
            XCTAssertEqual(self?.repository?.getPokemonsNumberOfCalls, 1)
        }
    }
}
