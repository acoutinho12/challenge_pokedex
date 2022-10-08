//
//  PokemonTests.swift
//  PokedexTests
//
//  Created by André Luis Barbosa Coutinho on 08/10/22.
//

import XCTest
@testable import Pokedex

class PokemonTests: XCTestCase {
    var pokemon: Any?
    var helper: PokemonMockHelpers?
    override func setUp() {
        super.setUp()
        helper = PokemonMockHelpers()
        pokemon = helper?.pokemonMock
    }

    override func tearDown() {
        pokemon = nil
        helper = nil
        super.tearDown()
    }

    func test_create_Pokemon_Model() {
        XCTAssertTrue(pokemon is Pokemon)
    }
}
